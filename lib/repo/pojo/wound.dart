class Wound {
  final int priority;
  final String type;
  final String severity;
  final String effect;

  const Wound(this.priority, this.type, this.severity, this.effect);
}

class WoundDeck {
  static const List<Wound> lightWound =  [

  ];
  static const List<Wound> mediumWound = [];
  static const List<Wound> deadlyWound = [];

  static const Wound lightWoundDef = Wound(0, WoundSource.any, "light", "Nothing");
  static const Wound cut = Wound(1, WoundSource.laceration, "light", "Cfffudft");
  static const Wound deepCut = Wound(2, WoundSource.laceration, "light", "Deep cut");
}

class WoundSource {
  static const String any = "any";
  static const String blunt = "blunt";
  static const String laceration = "laceration";
  static const String puncture = "puncture";
  static const String fire = "fire";
  static const String blight = "blight";
}
