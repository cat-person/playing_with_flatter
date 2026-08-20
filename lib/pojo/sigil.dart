import 'actions.dart';
import 'dice.dart';

class Sigil {
  final List<Modifier>? modifiers;
  final List<Action>? actions;
  final List<Dice>? dice;

  Sigil(this.modifiers, this.actions, this.dice);
}

class Modifier {
  String statId;
  int modifier;
  int upTo;

  Modifier(this.statId, this.modifier, this.upTo);
}
