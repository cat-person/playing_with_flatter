import 'package:snd/event_processor/event_processor.dart';
import 'package:snd/vm/battle_vm.dart';

import 'pojo/mc.dart';
import 'package:snd/event_processor/event.dart';

class TimelineRepo extends EventProcessor<List<TurnEvent>> {
  TimelineRepo({super.proxies}) : super([]);

  @override
  bool internalEventHandler(Event event) {
    switch (event.id) {
      case "schedule":
        return true;
      case "peekNext":
        return true;
      case "cancel":
        return true;
    }
    return false;
  }
}

// Just a collection of events
class TimelineState {
  final List<TurnEvent> currentEvents;
  final List<TurnEvent> futureEvents;

  TimelineState(this.currentEvents, this.futureEvents);
}
