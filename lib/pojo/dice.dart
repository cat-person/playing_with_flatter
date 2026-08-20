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

  Dice({required this.statId});

  roll(Random random) {
    return random.nextInt(6);
  }
}
