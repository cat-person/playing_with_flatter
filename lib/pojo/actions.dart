import 'dice.dart';
import 'hero.dart';

abstract class Action {
  bool canAddTarget(Target target);
  List<Target> addTarget(Target targets);
  clearTargets();

  bool canAddDice(Dice dice);
  List<Dice> addDice(Dice dice);
  clearDice();

  bool canPerform();
  List<Event> perform();
}

class ZombiHealAction extends Action {
  Hero self;
  List<Target> targets = [];
  List<Dice> payed = [];

  ZombiHealAction(this.self);

  @override
  bool canAddTarget(Target target) {
    return false;
  }

  @override
  List<Target> addTarget(Target target) {
    if (canAddTarget(target)) {
      targets.add(target);
    }
    return targets;
  }

  @override
  clearTargets() {
    targets.clear();
  }

  @override
  bool canAddDice(Dice dice) {
    return false;
  }

  @override
  List<Dice> addDice(Dice dice) {
    if (canAddDice(dice)) {
      payed.add(dice);
    }
    return payed;
  }

  @override
  clearDice() {
    payed.clear();
  }

  @override
  bool canPerform() {
    return false;
  }

  @override
  List<Event> perform() {
    if (canPerform()) {}
    return [];
  }
}

abstract class Price {
  Map<String, int> payed = {};
  // Returns isFullyPayed
  bool pay(String diceId, int diceValue);
  bool canBePayedBy(String diceId, int diceValue);
  bool isFullyPayed();
}

abstract class Target {}

abstract class Event {}
