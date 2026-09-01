import 'package:snd/event_processor/event_processor.dart';
import 'package:snd/repo/mc_repo.dart';
import 'package:snd/repo/origins_repo.dart';
import 'package:snd/repo/sigils_repo.dart';
import 'package:snd/event_processor/event.dart';
import 'package:snd/repo/pojo/origins.dart';
import 'package:snd/repo/pojo/mc.dart';
import 'package:snd/repo/pojo/sigil.dart';

class BattleVM extends EventProcessor<BattleState> {
  final MCRepo mcRepo;
  final OriginsRepo originsRepo;
  final SigilsRepo sigilsRepo;

  // final MC mc;
  // final Map<String, Origin> originColleciton;
  // final Map<String, Sigil> sigilCollection;

  BattleVM(this.mcRepo, this.originsRepo, this.sigilsRepo, {super.proxies})
    : super(BattleState(mc: mcRepo.latestState, originColleciton: originsRepo.latestState, sigilCollection: sigilsRepo.latestState)) {
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

class BattleState {
  final MC mc;
  final Map<String, Origin> originColleciton;
  final Map<String, Sigil> sigilCollection;

  BattleState({required this.mc, required this.originColleciton, required this.sigilCollection});

  BattleState copyWith({MC? mc, Map<String, Origin>? originColleciton, Map<String, Sigil>? sigilCollection}) {
    return BattleState(
      mc: mc ?? this.mc,
      originColleciton: originColleciton ?? this.originColleciton,
      sigilCollection: sigilCollection ?? this.sigilCollection,
    );
  }
}
