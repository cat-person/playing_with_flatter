class Creature {
  final String originId;
  final List<String> sigils;
  final Map<String, BodyPart> bodyparts;

  const Creature(this.originId, this.sigils, this.bodyparts);
}

class BodyPart {
  final String name;
  final List<String> tags;

  BodyPart(this.name, this.tags);
}

Creature rat = Creature("rat", [], {
  "body": BodyPart("body", ["body"]),
});
