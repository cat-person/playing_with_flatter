import 'package:snd/repo/pojo/wound.dart';
import 'package:snd/event_processor/event_processor.dart';
import 'package:snd/event_processor/event.dart';

class WoundDeckRepo extends EventProcessor<WoundDeckState> {
  WoundDeckRepo(super._latestState, {super.proxies});

  @override
  bool internalEventHandler(Event event) {
    switch (event.id) {
      case "shuffle":
        return true;
      case "draw":
        return true;
      default:
        return false;
    }
  }
}

class WoundDeckState {
  final List<String> drawnCards;
  final Map<String, Wound> woundColleciton;
  final Map<String, WoundDeck> deckColleciton;

  WoundDeckState(this.deckColleciton, this.woundColleciton, this.drawnCards);

  WoundDeckState copyWith({List<String>? drawnCards, Map<String, Wound>? woundColleciton, Map<String, WoundDeck>? deckColleciton}) {
    return WoundDeckState(deckColleciton ?? this.deckColleciton, woundColleciton ?? this.woundColleciton, drawnCards ?? this.drawnCards);
  }
}
