import 'package:snd/repo/pojo/wound.dart';
import 'package:snd/event_processor/event_processor.dart';
import 'package:snd/event_processor/event.dart';

class WoundDeckRepo extends EventProcessor<WoundDeckState> {
  WoundDeckRepo(super._latestState, {super.proxies});

  @override
  bool internalEventHandler(Event event) {
    switch (event.id) {
      case "shuffle":
        String? deckId = event.params["deck_id"];
        if (deckId != null) {
          WoundDeck? deck = latestState.deckCollection[deckId];
          if (deck != null) {
            deck.shuffle();
            latestState.deckCollection[deckId] = deck;
            update(latestState.copyWith(deckCollection: latestState.deckCollection));
            return true;
          }
        }
        return false;
      case "draw":
        String? deckId = event.params["deck_id"];
        int? howMany = event.params["how_many"];
        if (deckId != null && howMany != null) {
          WoundDeck? deck = latestState.deckCollection[deckId];
          if (deck != null) {
            deck.draw(howMany);
            return true;
          }
        }
        return false;
      default:
        return false;
    }
  }
}

class WoundDeckState {
  final List<String> drawnCards;
  final Map<String, Wound> woundCollection;
  final Map<String, WoundDeck> deckCollection;

  WoundDeckState(this.deckCollection, this.woundCollection, this.drawnCards);

  WoundDeckState copyWith({List<String>? drawnCards, Map<String, Wound>? woundCollection, Map<String, WoundDeck>? deckCollection}) {
    return WoundDeckState(deckCollection ?? this.deckCollection, woundCollection ?? this.woundCollection, drawnCards ?? this.drawnCards);
  }
}
