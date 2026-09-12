import 'package:snd/event_processor/event_processor.dart';
import 'dart:math';

import 'pojo/origins.dart';
import 'pojo/creature.dart';
import 'pojo/sigil.dart';
import 'package:snd/event_processor/event.dart';

class CreaturesRepo extends EventProcessor<Map<String, Creature>> {
  CreaturesRepo({super.proxies}) : super(creatureCollection);

  @override
  bool internalEventHandler(Event event) {
    return false;
  }
}

extension CreatureExt on Creature {
  Map<String, int> get stats {
    Map<String, int> stats = Map.from(originCollection[originId]?.primaryStats ?? {});
    for (String sigilId in sigils) {
      List<Modifier>? sigilModifiers = sigilCollection[sigilId]?.modifiers?..sort((first, second) => second.upTo.compareTo(first.upTo));
      if (sigilModifiers != null) {
        for (Modifier modifier in sigilModifiers) {
          int currentStat = stats[modifier.statId] ?? 0;
          stats[modifier.statId] = min(currentStat + modifier.value, modifier.upTo);
        }
      }
    }
    return stats;
  }
}
