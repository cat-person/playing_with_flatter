import 'package:snd/repo/pojo/wound.dart';
import 'package:snd/event_processor/event_processor.dart';
import 'package:snd/event_processor/event.dart';

class WoundDeckRepo extends EventProcessor<Map<String, WoundDeck>> {
  final WoundDeck lightDeck;
  final WoundDeck mediumDeck;
  final WoundDeck severeDeck;

  WoundDeckRepo({required this.lightDeck, required this.mediumDeck, required this.severeDeck, super.proxies})
    : super({"light": WoundDeck([]), "medium": WoundDeck([]), "severe": WoundDeck([])});

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
