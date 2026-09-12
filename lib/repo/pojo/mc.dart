import 'package:snd/repo/pojo/creature.dart';

import 'origins.dart';

class MC extends Creature {
  // Creature(this.id, this.originId, this.sigils, this.bodyparts)
  MC(String originId, List<String> sigils, List<String> bodyParts)
    : super("mc", originId, sigils, bodyParts); //this.actions = const ["punch", "heal"]

  MC copyWith({String? originId, List<String>? sigils, List<String>? bodyParts}) {
    return MC(originId ?? this.originId, sigils ?? this.sigils, bodyParts ?? this.bodyParts);
  }
}
