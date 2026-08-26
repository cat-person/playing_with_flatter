import 'package:snd/event_processor/event_processor.dart';
import 'package:snd/repo/origins_repo.dart';
import 'package:snd/repo/sigils_repo.dart';
import 'package:snd/event_processor/event.dart';
import '../../repo/pojo/origins.dart';
import '../../repo/pojo/sigil.dart';

class MainVM extends EventProcessor<MainState> {
  MainVM(OriginsRepo originsRepo, SigilsRepo sigilsRepo, {super.proxy})
    : super(
        MainState(
          origins: originsRepo.latestState,
          selectedOrigin: "",
          sigils: sigilsRepo.latestState,
        ),
      );

  @override
  bool internalEventHandler(Event event) {
    switch (event.id) {
      case "select_origin":
        update(
          latestState.copyWith(
            selectedOrigin: event.params["selected_origin"] as String,
          ),
        );
        return true;
      default:
        return false;
    }
  }
}

class MainState {
  final Map<String, Origin> origins;
  final Map<String, Sigil> sigils;
  final String selectedOrigin;

  const MainState({
    required this.origins,
    required this.selectedOrigin,
    required this.sigils,
  });

  MainState copyWith({
    Map<String, Origin>? origins,
    String? selectedOrigin,
    Map<String, Sigil>? sigils,
  }) {
    return MainState(
      origins: origins ?? this.origins,
      selectedOrigin: selectedOrigin ?? this.selectedOrigin,
      sigils: sigils ?? this.sigils,
    );
  }
}
