import 'package:snd/event_processor/event_processor.dart';
import 'package:snd/repo/mc_repo.dart';
import 'package:snd/repo/origins_repo.dart';
import 'package:snd/repo/pojo/creature.dart';
import 'package:snd/repo/pojo/wound.dart';
import 'package:snd/repo/sigils_repo.dart';
import 'package:snd/event_processor/event.dart';
import 'package:snd/repo/pojo/origins.dart';
import 'package:snd/repo/pojo/mc.dart';
import 'package:snd/repo/pojo/sigil.dart';
import 'package:snd/repo/wound_deck_repo.dart';
import 'package:snd/repo/creatures_repo.dart';

class BattleVM extends EventProcessor<BattleState> {
  final MCRepo mcRepo;
  final CreaturesRepo creaturesRepo;
  final WoundDeckRepo woundDeckRepo;
  final OriginsRepo originsRepo;
  final SigilsRepo sigilsRepo;
  // final MC mc;
  // final Map<String, Origin> originColleciton;
  // final Map<String, Sigil> sigilCollection;

  BattleVM(this.mcRepo, this.creaturesRepo, this.woundDeckRepo, this.originsRepo, this.sigilsRepo, {super.proxies})
    : super(
        BattleState(
          mc: mcRepo.latestState,
          enemies: creaturesRepo.latestState,
          drawnCards: woundDeckRepo.latestState.drawnCards,
          woundDeckCollection: woundDeckRepo.latestState.deckCollection,
          woundCollection: woundDeckRepo.latestState.woundCollection,
          originColleciton: originsRepo.latestState,
          sigilCollection: sigilsRepo.latestState,
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
  final Map<String, Creature> enemies;
  final List<String> drawnCards;
  final Map<String, WoundDeck> woundDeckCollection;
  final Map<String, Wound> woundCollection;
  final Map<String, Origin> originColleciton;
  final Map<String, Sigil> sigilCollection;

  BattleState({
    required this.mc,
    required this.enemies,
    required this.drawnCards,
    required this.woundDeckCollection,
    required this.woundCollection,
    required this.originColleciton,
    required this.sigilCollection,
  });
  BattleState copyWith({
    MC? mc,
    Map<String, Creature>? enemies,
    List<String>? drawnCards,
    Map<String, WoundDeck>? woundDeckCollection,
    Map<String, Wound>? woundCollection,
    Map<String, Origin>? originColleciton,
    Map<String, Sigil>? sigilCollection,
  }) {
    return BattleState(
      mc: mc ?? this.mc,
      enemies: enemies ?? this.enemies,
      drawnCards: drawnCards ?? this.drawnCards,
      woundDeckCollection: woundDeckCollection ?? this.woundDeckCollection,
      woundCollection: woundCollection ?? this.woundCollection,
      originColleciton: originColleciton ?? this.originColleciton,
      sigilCollection: sigilCollection ?? this.sigilCollection,
    );
  }
}
