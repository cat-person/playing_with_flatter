import 'package:snd/event_processor/event_processor.dart';
import 'package:snd/repo/mc_repo.dart';
import 'package:snd/repo/origins_repo.dart';
import 'package:snd/repo/sigils_repo.dart';
import 'package:snd/event_processor/event.dart';
import 'package:snd/repo/pojo/origins.dart';
import 'package:snd/repo/pojo/mc.dart';
import 'package:snd/repo/pojo/sigil.dart';

class CharacterCreationVM extends EventProcessor<CharacterCreationState> {
  final MCRepo mcRepo;
  final OriginsRepo originsRepo;
  final SigilsRepo sigilsRepo;

  CharacterCreationVM(this.mcRepo, this.originsRepo, this.sigilsRepo, {super.proxies})
    : super(
        CharacterCreationState(
          mc: mcRepo.latestState,
          originColleciton: originsRepo.latestState,
          sigilCollection: sigilsRepo.latestState,
          sigilSelection: originsRepo.latestState[mcRepo.latestState.originId]?.sigilSelection ?? [],
        ),
      ) {
    mcRepo.stream.listen(
      (data) => update(latestState.copyWith(mc: data, sigilSelection: originsRepo.latestState[data.originId]?.sigilSelection ?? [])),
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

  List<SigilSelection> getSigilSelection() {
    String originId = mcRepo.latestState.originId;
    Origin? origin = originsRepo.latestState[originId];

    if (origin != null) {
      return origin.sigilSelection;
    } else {
      return [];
    }
  }
}

class CharacterCreationState {
  final MC mc;
  final List<SigilSelection> sigilSelection;
  final Map<String, Origin> originColleciton;
  final Map<String, Sigil> sigilCollection;

  CharacterCreationState({required this.mc, required this.sigilSelection, required this.originColleciton, required this.sigilCollection});

  CharacterCreationState copyWith({
    MC? mc,
    List<SigilSelection>? sigilSelection,
    Map<String, Origin>? originColleciton,
    Map<String, Sigil>? sigilCollection,
  }) {
    return CharacterCreationState(
      mc: mc ?? this.mc,
      sigilSelection: sigilSelection ?? this.sigilSelection,
      originColleciton: originColleciton ?? this.originColleciton,
      sigilCollection: sigilCollection ?? this.sigilCollection,
    );
  }
}
