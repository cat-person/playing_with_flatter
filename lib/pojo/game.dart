import 'dart:math';
import 'Action.dart';

class Game {
  // final Player {
  //   var stats = Stats();
  // }
  List<Action> actions = [];
}

class Stats {}

class Intelligence {
  List<Dice> getDice() {
    return [Dice()];
  }
}

enum PrimaryStatIds {
  endurance,
  intelligence,
  speed,
  strength
} // You'll be given dice

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
