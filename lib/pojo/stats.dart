import 'dice.dart';
import 'actions.dart';
import 'sigil.dart';

// 1:   Crippled pathetic shuttered
// 2:
// 3:   Weak below average
// 4:
// 5:   Average for speciment in their prime
// 6:
// 7:   Profficient competent
// 8:
// 9:   Very good on top of their game
// 10:
// 11:  Increadibly gifted genius beyond what is achiavable normally you can only get to this level temporary or via compromising other stats
// 12:

abstract class Stat {
  String statId;
  Stat(this.statId);

  int getVal();
  List<Action> getActions();
}

abstract class PrimaryStat extends Stat {
  static const String mysticism = "mysticism";
  static const String strength = "strength";
  static const String speed = "speed";
  static const String perception = "perception";
  static const String constitution = "constitution";
  static const String charisma = "charisma";

  List<Modifier> modifiers;
  PrimaryStat(super.statId, this.modifiers);
  List<Dice> getDice();
}

abstract class SynthStat extends Stat {
  Map<String, PrimaryStat> primaryStats;
  SynthStat(super.statId, this.primaryStats);
}
