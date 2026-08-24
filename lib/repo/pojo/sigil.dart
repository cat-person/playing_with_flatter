import 'actions.dart';
import 'dice.dart';

class Sigil {
  final String id;
  final List<Modifier>? modifiers;
  final List<Action>? actions;
  final List<Dice>? dice;

  const Sigil(this.id, this.modifiers, this.actions, this.dice);
}

class Modifier {
  String statId;
  int modifier;
  int upTo;

  Modifier(this.statId, this.modifier, this.upTo);
}

const Map<String, Sigil> sigils = {
  "mystic": Sigils.mystic,
  "muscular": Sigils.muscular,
  "fast_hands": Sigils.fastHands,
  "perceptive": Sigils.perceptive,
  "hardy": Sigils.hardy,
  "pretender": Sigils.pretender,

  //Flash Construct
  "viscerblade": Sigils.viscerblade,
  "thorn_skinned": Sigils.thornSkinned,
  "crimson_gout": Sigils.crimsonGout,

  //Ferathrope
  "echolocation": Sigils.echolocation,
  "pit_organ": Sigils.pitOrgan,
  "venomous_bite": Sigils.venomousBite,
  "ember_flesh": Sigils.emberFlesh,

  //Vampire
  "charming": Sigils.charming,
  "predator_sense": Sigils.predatorSense,

  //Witch
  "book_of_secrets": Sigils.bookOfSecrets,
  "book_of_spikes": Sigils.bookOfSpikes,
  "book_of_mirrors": Sigils.bookOfMirrors,
  // Blight Weaver
  "feverish": Sigils.feverish,
  "rot_shaper": Sigils.rotShaper,
  "flesh_bender": Sigils.fleshBender,

  // Hunter
  "pain_master": Sigils.painMaster,
  "hollowsouled": Sigils.hollowSouled,
  //
  "hummer_sworn": Sigils.hummerSworn,
  "dagger_master": Sigils.daggerMaster,
  "rapier_master": Sigils.rapierMaster,
  "master_of_weaves": Sigils.masterOfWeaves,
};

class Sigils {
  static const Sigil mystic = Sigil("mystic", [], [], []);
  static const Sigil muscular = Sigil("muscular", [], [], []);
  static const Sigil fastHands = Sigil("fast_hands", [], [], []);
  static const Sigil perceptive = Sigil("perceptive", [], [], []);
  static const Sigil hardy = Sigil("hardy", [], [], []);
  static const Sigil pretender = Sigil("pretender", [], [], []);

  //Flash Construct
  static const Sigil viscerblade = Sigil("viscerblade", [], [], []);
  static const Sigil thornSkinned = Sigil("thorn_skinned", [], [], []);
  static const Sigil crimsonGout = Sigil("crimson_gout", [], [], []);

  //Ferathrope
  static const Sigil echolocation = Sigil("echolocation", [], [], []);
  static const Sigil pitOrgan = Sigil("pit_organ", [], [], []);
  static const Sigil venomousBite = Sigil("venomous_bite", [], [], []);
  static const Sigil emberFlesh = Sigil("ember_flesh", [], [], []);

  //Vampire
  static const Sigil charming = Sigil("charming", [], [], []);
  static const Sigil predatorSense = Sigil("predator_sense", [], [], []);

  //Witch
  static const Sigil bookOfSecrets = Sigil("book_of_secrets", [], [], []);
  static const Sigil bookOfSpikes = Sigil("book_of_spikes", [], [], []);
  static const Sigil bookOfMirrors = Sigil("book_of_mirrors", [], [], []);

  // Blight Weaver
  static const Sigil feverish = Sigil("feverish", [], [], []);
  static const Sigil rotShaper = Sigil("rot_shaper", [], [], []);
  static const Sigil fleshBender = Sigil("flesh_bender", [], [], []);

  // Hunter
  static const Sigil painMaster = Sigil("pain_master", [], [], []);
  static const Sigil hollowSouled = Sigil("hollowsouled", [], [], []);
  //
  static const Sigil hummerSworn = Sigil("hummer_sworn", [], [], []);
  static const Sigil daggerMaster = Sigil("dagger_master", [], [], []);
  static const Sigil rapierMaster = Sigil("rapier_master", [], [], []);
  static const Sigil masterOfWeaves = Sigil("master_of_weaves", [], [], []);
}
