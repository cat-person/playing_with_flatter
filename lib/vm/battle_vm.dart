import 'package:snd/event_processor/event_processor.dart';
import 'package:snd/repo/mc_repo.dart';
import 'package:snd/repo/origins_repo.dart';
import 'package:snd/repo/pojo/creature.dart';
import 'package:snd/repo/pojo/wound.dart';
import 'package:snd/repo/sigils_repo.dart';
import 'package:snd/event_processor/event.dart';
import 'package:snd/repo/pojo/origins.dart';
import 'package:snd/repo/pojo/mc.dart';
import 'package:snd/repo/pojo/dice.dart';
import 'package:snd/repo/pojo/sigil.dart';
import 'package:snd/repo/wound_deck_repo.dart';
import 'package:snd/repo/creatures_repo.dart';
import 'package:snd/repo/timeline_repo.dart';

import 'package:collection/collection.dart';
import 'dart:math';

class BattleVM extends EventProcessor<BattleState> {
  final MCRepo mcRepo;
  final CreaturesRepo creaturesRepo;
  final WoundDeckRepo woundDeckRepo;
  final OriginsRepo originsRepo;
  final SigilsRepo sigilsRepo;
  final TimelineRepo timelineRepo;
  final Timeline timeline = Timeline();

  BattleVM(this.mcRepo, this.creaturesRepo, this.woundDeckRepo, this.originsRepo, this.sigilsRepo, this.timelineRepo, {super.proxies})
    : super(
        BattleState(
          mc: mcRepo.latestState,
          dices: {},
          enemies: creaturesRepo.latestState,
          drawnCards: woundDeckRepo.latestState.drawnCards,
          woundDeckCollection: woundDeckRepo.latestState.deckCollection,
          woundCollection: woundDeckRepo.latestState.woundCollection,
          originColleciton: originsRepo.latestState,
          sigilCollection: sigilsRepo.latestState,
          timeline: [],
        ),
      ) {
    mcRepo.stream.listen(
      (data) => update(latestState.copyWith(mc: data)),
      onError: (error) => print('Error: $error'),
      onDone: () => print('Stream closed'),
      cancelOnError: false,
    );

    timelineRepo.stream.listen(
      (data) => update(latestState.copyWith(timeline: data.events)),
      onError: (error) => print('Error: $error'),
      onDone: () => print('Stream closed'),
      cancelOnError: false,
    );

    // Place actors in da turn queue
    for (Creature creature in [latestState.mc, ...latestState.enemies.values]) {
      int pcp = creature.stats["pcp"] ?? 1;
      int spd = creature.stats["spd"] ?? 2;
      timelineRepo.eventHandler(
        Event("schedule_turn", params: {"actor_id": creature.id, "delay": log2(pcp * spd).round()}),
      ); //(10.0 - log2(initiative)).round()
    }
  }

  double log2(num x) {
    // if (x is int && x > 0 && (x & (x - 1)) == 0) {
    //   return (x.bitLength - 1).toDouble(); // exact
    // }
    return log(x) * log2e;
  }

  @override
  bool internalEventHandler(Event event) {
    switch (event.id) {
      case "schedule_turn":
        timelineRepo.eventHandler(event);
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
  final Map<String, Dice> dices;
  final List<String> drawnCards;
  final Map<String, WoundDeck> woundDeckCollection;
  final Map<String, Wound> woundCollection;
  final Map<String, Origin> originColleciton;
  final Map<String, Sigil> sigilCollection;
  final List<TurnEvent> timeline;

  BattleState({
    required this.mc,
    required this.enemies,
    required this.dices,
    required this.drawnCards,
    required this.woundDeckCollection,
    required this.woundCollection,
    required this.originColleciton,
    required this.sigilCollection,
    required this.timeline,
  });
  BattleState copyWith({
    MC? mc,
    Map<String, Creature>? enemies,
    Map<String, Dice>? dices,
    List<String>? drawnCards,
    Map<String, WoundDeck>? woundDeckCollection,
    Map<String, Wound>? woundCollection,
    Map<String, Origin>? originColleciton,
    Map<String, Sigil>? sigilCollection,
    List<TurnEvent>? timeline,
  }) {
    return BattleState(
      mc: mc ?? this.mc,
      dices: dices ?? this.dices,
      enemies: enemies ?? this.enemies,
      drawnCards: drawnCards ?? this.drawnCards,
      woundDeckCollection: woundDeckCollection ?? this.woundDeckCollection,
      woundCollection: woundCollection ?? this.woundCollection,
      originColleciton: originColleciton ?? this.originColleciton,
      sigilCollection: sigilCollection ?? this.sigilCollection,
      timeline: timeline ?? this.timeline,
    );
  }
}

// Move to separate repo ?
// Turns is not ABABAB
// If creature A is faster it can be ABABAA..
class Timeline {
  final _heap = HeapPriorityQueue<TurnEvent>((te1, te2) => te2.eventTurn.compareTo(te1.eventTurn));
  int now = 0; // i64

  final Map<String, List<TurnEvent>> actionsByActorId = {};

  TurnEvent proceedToNext() {
    TurnEvent next = _heap.removeFirst();

    List<TurnEvent>? events = actionsByActorId[next.actorId];

    if (events != null) {
      events.remove(next);
    }

    now = next.eventTurn;
    return next;
  }

  void schedule(TurnEvent event) {
    _heap.add(event);
  }

  // cancelByActorId() {}
}
