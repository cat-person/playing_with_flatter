import 'package:snd/event_processor/event_processor.dart';
import 'package:snd/event_processor/event.dart';

class ConsoleProxy extends EventProcessor<List<Event>> {
  ConsoleProxy() : super([]);

  @override
  bool internalEventHandler(Event event) {
    update([event, ...latestState]);
    return true;
  }
}
