import 'package:snd/repo/pojo/origins.dart';
import 'package:snd/repo/pojo/sigil.dart';
import 'package:snd/repo/pojo/dice.dart';

class Creature {
  final String id;
  final String originId;
  final List<String> sigils;
  final List<String> bodyParts;

  const Creature(this.id, this.originId, this.sigils, this.bodyParts);

  Map<String, int> get stats {
    Map<String, int> result = Map.from(originCollection[originId]?.primaryStats ?? {});
    sigils.map((sigilId) => sigilCollection[sigilId]).expand((sigil) => sigil?.modifiers ?? []).toList()
      ..sort((modifier, otherModifier) => otherModifier.upTo.compareTo(modifier.upTo))
      ..forEach((modifier) {
        result[modifier.statId] = (result[modifier.statId] ?? 0) + modifier.value as int;
      });

    return result;
  }

  Map<String, int> getDicesCnt() {
    Map<String, int> result = {};
    stats.entries.forEach((entry) {
      result[entry.key] = getDiceCntByStat(entry.key, entry.value);
    });
    return result;
  }

  int getDiceCntByStat(String statId, int statVal) {
    switch (statId) {
      default:
        return statVal ~/ 4;
    }
  }
}

class BodyPart {
  final String name;
  final List<String> tags;

  BodyPart(this.name, this.tags);
}

Map<String, Creature> creatureCollection = {
  "rat": Creature("Rat", "rat", [], ["body"]),
  "blob": Creature("Blob", "blob", [], ["body"]),
  "wolf": Creature("Wolf", "wolf", [], ["body"]),
  "wisp": Creature("Wisp", "wisp", [], ["body"]),
};
