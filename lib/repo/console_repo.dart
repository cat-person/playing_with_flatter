import 'package:snd/event_processor/event_processor.dart';
import 'package:snd/event_processor/event.dart';

class ConsoleRepo extends EventProcessor<List<Event>> {
  ConsoleRepo() : super([]);

  @override
  bool internalEventHandler(Event event) {
    update([event, ...latestState]);
    return true;
  }
}
