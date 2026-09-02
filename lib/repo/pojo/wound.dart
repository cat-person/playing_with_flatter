class Wound {
  final int priority;
  final String type;
  final String severity;
  final String effect;

  const Wound(this.priority, this.type, this.severity, this.effect);
}

const String tagLight = "wound_light";
const String tagMedium = "wound_medium";
const String tagSevere = "wound_severe";

const Map<String, Wound> woundCollection = {
  "light": AnySet.light,
  "serious": AnySet.serious,
  "severe": AnySet.severe,

  "cut": LacerationSet.cut,
  "compound_laceration": LacerationSet.compoundLaceration,
  "tendon_rupture": LacerationSet.tendonRupture,
  "arterial_rupture": LacerationSet.arterialRupture,
  "bisection": LacerationSet.bisection,

  "bruise": BluntSet.bruise,
  "bone_crack": BluntSet.boneCrack,
  "muscle_crush": BluntSet.muscleCrush,
  "compound_fracture": BluntSet.compoundFracture,
  "obliteration": BluntSet.obliteration,
};

class WoundDeck {
  final String id;
  List<String> _deck;

  WoundDeck(this.id, this._deck);

  void shuffle() {
    _deck.shuffle();
  }

  List<String> draw(int howMany) {
    // deck
    List<String> result = _deck.skip(_deck.length - howMany).toList();
    _deck = _deck.take(_deck.length - howMany).toList();
    return result;
  }
}

class WoundSource {
  static const String any = "any";
  static const String blunt = "blunt";
  static const String laceration = "laceration";
  static const String puncture = "puncture";
  static const String fire = "fire";
  static const String blight = "blight";
}

class LightDeck extends WoundDeck {
  LightDeck()
    : super("wound_light", [
        ...List<String>.filled(20, "light"),
        ...List<String>.filled(4, "cut"),
        ...List<String>.filled(4, "compound_laceration"),
        ...List<String>.filled(4, "bruise"),
        ...List<String>.filled(4, "bone_crack"),
      ]);
}

class SeriousDeck extends WoundDeck {
  SeriousDeck()
    : super("wound_serious", [
        ...List<String>.filled(20, "serious"),
        ...List<String>.filled(4, "tendon_rupture"),
        ...List<String>.filled(4, "arterial_rupture"),
        ...List<String>.filled(4, "muscle_crush"),
        ...List<String>.filled(4, "compound_fracture"),
      ]);
}

class SevereDeck extends WoundDeck {
  SevereDeck()
    : super("wound_severe", [
        ...List<String>.filled(10, "severe"),
        ...List<String>.filled(4, "bisection"),
        ...List<String>.filled(4, "obliteration"),
      ]);
}

class LacerationSet {
  static const Wound cut = Wound(1, WoundSource.laceration, "light", "Cut");
  static const Wound compoundLaceration = Wound(2, WoundSource.laceration, "light", "Compund laceration");

  static const Wound tendonRupture = Wound(3, WoundSource.laceration, "medium", "Tendrom cut");
  static const Wound arterialRupture = Wound(3, WoundSource.laceration, "medium", "Deep cut");

  static const Wound bisection = Wound(4, WoundSource.laceration, "light", "Bisection");
}

class BluntSet {
  static const Wound bruise = Wound(1, WoundSource.blunt, "light", "Bruise");
  static const Wound boneCrack = Wound(2, WoundSource.blunt, "light", "Bone Crack");

  static const Wound muscleCrush = Wound(3, WoundSource.blunt, "light", "Muscle crush");
  static const Wound compoundFracture = Wound(3, WoundSource.blunt, "light", "Compound Fracture");

  static const Wound obliteration = Wound(4, WoundSource.blunt, "light", "Obliteration");
}

class AnySet {
  static const Wound light = Wound(1, WoundSource.blunt, "light", "Light");
  static const Wound serious = Wound(2, WoundSource.blunt, "serious", "Serious");
  static const Wound severe = Wound(3, WoundSource.blunt, "severe", "Severe");
}
