import 'package:snd/event_processor/event_processor.dart';

import 'pojo/origins.dart';
import 'pojo/creature.dart';
import 'package:snd/event_processor/event.dart';

class CreaturesRepo extends EventProcessor<Map<String, Creature>> {
  CreaturesRepo({super.proxies}) : super(creatureCollection);

  @override
  bool internalEventHandler(Event event) {
    return false;
  }
}
