import 'package:snd/repo/pojo/origins.dart';

import 'dice.dart';

class Creature {
  final String id;
  final String originId;
  final List<String> sigils;
  final Map<String, BodyPart> bodyparts;

  const Creature(this.id, this.originId, this.sigils, this.bodyparts);
  Map<String, int> get stats {
    Map<String, int> result = Map.from(originCollection[originId]?.primaryStats ?? {});
    for (String sigilId in sigils) {}
    return result;
  }
}

class BodyPart {
  final String name;
  final List<String> tags;

  BodyPart(this.name, this.tags);
}

Map<String, Creature> creatureCollection = {
  "rat": Creature("Rat", "rat", [], {
    "body": BodyPart("body", ["body"]),
  }),
  "blob": Creature("Blob", "blob", [], {
    "body": BodyPart("body", ["body"]),
  }),
  "wolf": Creature("Wolf", "wolf", [], {
    "body": BodyPart("body", ["body"]),
  }),
  "wisp": Creature("Wisp", "wisp", [], {
    "body": BodyPart("body", ["body"]),
  }),
};

// Map<String, Dice> getDicesByStat(Creature creature) {
//   Map<String, Dice> result = {};
//   creature.stats.{

//   }

//   return result;
// }
