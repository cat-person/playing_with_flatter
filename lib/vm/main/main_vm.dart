import 'package:snd/event_processor/event_processor.dart';
import 'package:snd/repo/mc_repo.dart';
import 'package:snd/repo/origins_repo.dart';
import 'package:snd/repo/sigils_repo.dart';
import 'package:snd/event_processor/event.dart';
import 'package:snd/repo/pojo/origins.dart';
import 'package:snd/repo/pojo/sigil.dart';
import 'package:snd/repo/pojo/mc.dart';

class MainVM extends EventProcessor<MainState> {
  final MCRepo mcRepo;
  final OriginsRepo originsRepo;
  final SigilsRepo sigilsRepo;

  MainVM(this.mcRepo, this.originsRepo, this.sigilsRepo, {super.proxy})
    : super(
        MainState(
          mc: mcRepo.latestState,
          origins: originsRepo.latestState,
          sigils: sigilsRepo.latestState,
        ),
      ) {
    mcRepo.stream.listen(
      (data) => update(latestState.copyWith(mc: data)),
      onError: (error) => print('Error: $error'),
      onDone: () => print('Stream closed'),
      cancelOnError: false,
    );
  }

  @override
  bool internalEventHandler(Event event) {
    switch (event.id) {
      case "origin_selected":
        mcRepo.eventHandler(event);
        return true;
      case "sigil_selected":
        mcRepo.eventHandler(event);
        return true;
      default:
        return false;
    }
  }
}

class MainState {
  final MC mc;
  final Map<String, Origin> origins;
  final Map<String, Sigil> sigils;

  const MainState({
    required this.mc,
    required this.origins,
    required this.sigils,
  });

  MainState copyWith({
    MC? mc,
    Map<String, Origin>? origins,
    Map<String, Sigil>? sigils,
  }) {
    return MainState(
      mc: mc ?? this.mc,
      origins: origins ?? this.origins,
      sigils: sigils ?? this.sigils,
    );
  }
}
