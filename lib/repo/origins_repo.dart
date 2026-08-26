import 'package:snd/event_processor/event_processor.dart';

import 'pojo/origins.dart';
import 'package:snd/event_processor/event.dart';

class OriginsRepo extends EventProcessor<Map<String, Origin>> {
  OriginsRepo({super.proxy}) : super(defaultOrigins);

  @override
  bool internalEventHandler(Event event) {
    return false;
  }
}
