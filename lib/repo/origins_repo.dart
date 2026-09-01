import 'package:snd/event_processor/event_processor.dart';

import 'pojo/origins.dart';
import 'package:snd/event_processor/event.dart';

class OriginsRepo extends EventProcessor<Map<String, Origin>> {
  // final OriginsReader reader = OriginsReader("origins.json");
  OriginsRepo({super.proxies}) : super(defaultOrigins) {
    // reader.eventHandler(Event("load"));
  }

  @override
  bool internalEventHandler(Event event) {
    return false;
  }
}
