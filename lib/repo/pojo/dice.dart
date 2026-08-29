import 'dart:math';

abstract class DiceProvider {
  String getId();
  List<Dice> getDice();
}

class DiceRoll {
  String statId = "meow";
  int roll = 0;
}

class Dice {
  String statId;

  Dice(this.statId);

  roll(Random random) {
    return random.nextInt(6);
  }
}

class Dices {
  static const String mysticism = "mst";
  static const String strength = "str";
  static const String speed = "spd";
  static const String perception = "pcp";
  static const String constitution = "con";
  static const String intelligence = "int";
}
