class Creature {
  final String name;
  final String originId;
  final List<String> sigils;
  final Map<String, BodyPart> bodyparts;

  const Creature(this.name, this.originId, this.sigils, this.bodyparts);
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
  "bat": Creature("Bat", "bat", [], {
    "body": BodyPart("body", ["body"]),
  }),
  "wolf": Creature("Wolf", "wolf", [], {
    "body": BodyPart("body", ["body"]),
  }),
};
