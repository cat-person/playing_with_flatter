import 'actions.dart';
import 'dice.dart';

class Sigil {
  final String id;
  final String tag;
  final List<Modifier>? modifiers;
  final List<Action>? actions;
  final List<Dice>? dice;

  const Sigil(this.id, this.tag, this.modifiers, this.actions, this.dice);
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
  "regenerative": Sigils.regenerative,
  "wounded_shard": Sigils.woundedShard,
  "skinned": Sigils.skinned,

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
  static const Sigil mystic = Sigil("mystic", "common", [], [], []);
  static const Sigil muscular = Sigil("muscular", "common", [], [], []);
  static const Sigil fastHands = Sigil("fast_hands", "common", [], [], []);
  static const Sigil perceptive = Sigil("perceptive", "common", [], [], []);
  static const Sigil hardy = Sigil("hardy", "common", [], [], []);
  static const Sigil pretender = Sigil("pretender", "common", [], [], []);

  //Flash Construct
  static const Sigil viscerblade = Sigil(
    "viscerblade",
    "flash_construct",
    [],
    [],
    [],
  );
  static const Sigil thornSkinned = Sigil(
    "thorn_skinned",
    "flash_construct",
    [],
    [],
    [],
  );
  static const Sigil crimsonGout = Sigil(
    "crimson_gout",
    "flash_construct",
    [],
    [],
    [],
  );
  static const Sigil regenerative = Sigil(
    "regenerative",
    "flash_construct",
    [],
    [],
    [],
  );
  static const Sigil woundedShard = Sigil(
    "wounded_shard",
    "flash_construct",
    [],
    [],
    [],
  );
  static const Sigil skinned = Sigil("skinned", "flash_construct", [], [], []);

  //Ferathrope
  static const Sigil echolocation = Sigil(
    "echolocation",
    "ferathrope",
    [],
    [],
    [],
  );
  static const Sigil pitOrgan = Sigil("pit_organ", "ferathrope", [], [], []);
  static const Sigil venomousBite = Sigil(
    "venomous_bite",
    "ferathrope",
    [],
    [],
    [],
  );
  static const Sigil emberFlesh = Sigil(
    "ember_flesh",
    "ferathrope",
    [],
    [],
    [],
  );

  //Vampire
  static const Sigil charming = Sigil("charming", "vampire", [], [], []);
  static const Sigil predatorSense = Sigil(
    "predator_sense",
    "vampire",
    [],
    [],
    [],
  );

  //Witch
  static const Sigil bookOfSecrets = Sigil(
    "book_of_secrets",
    "witch",
    [],
    [],
    [],
  );
  static const Sigil bookOfSpikes = Sigil(
    "book_of_spikes",
    "witch",
    [],
    [],
    [],
  );
  static const Sigil bookOfMirrors = Sigil(
    "book_of_mirrors",
    "witch",
    [],
    [],
    [],
  );

  // Blight Weaver
  static const Sigil feverish = Sigil("feverish", "blight_weaver", [], [], []);
  static const Sigil rotShaper = Sigil(
    "rot_shaper",
    "blight_weaver",
    [],
    [],
    [],
  );
  static const Sigil fleshBender = Sigil(
    "flesh_bender",
    "blight_weaver",
    [],
    [],
    [],
  );

  // Hunter
  static const Sigil painMaster = Sigil(
    "pain_master",
    "hunter_orden",
    [],
    [],
    [],
  );
  static const Sigil hollowSouled = Sigil(
    "hollowsouled",
    "hunter_orden",
    [],
    [],
    [],
  );
  static const Sigil hummerSworn = Sigil(
    "hummer_sworn",
    "hunter_orden",
    [],
    [],
    [],
  );
  static const Sigil daggerMaster = Sigil(
    "dagger_master",
    "hunter",
    [],
    [],
    [],
  );
  static const Sigil rapierMaster = Sigil(
    "rapier_master",
    "hunter",
    [],
    [],
    [],
  );
  static const Sigil masterOfWeaves = Sigil(
    "master_of_weaves",
    "hunter",
    [],
    [],
    [],
  );
}
