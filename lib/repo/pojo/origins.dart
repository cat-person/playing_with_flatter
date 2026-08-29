import 'stats.dart';
import 'sigil.dart';

Map<String, Origin> defaultOrigins = {
  // Const ++ Str + myst - per - char -
  "flash_construct": Origin(
    {
      PrimaryStat.mysticism: 2,
      PrimaryStat.strength: 6,
      PrimaryStat.speed: 5,
      PrimaryStat.perception: 3,
      PrimaryStat.intelligence: 2,
      PrimaryStat.constitution: 7,
    },
    [
      SigilSelection(["viscerblade", "thorn_skinned", "crimson_gout", "regenerative", "wounded_shard", "skinned"], 2),
    ],
  ),
  // Const ++ Str + myst - per - char -
  "ferathrope": Origin(
    {
      PrimaryStat.mysticism: 4,
      PrimaryStat.strength: 4,
      PrimaryStat.speed: 6,
      PrimaryStat.perception: 6,
      PrimaryStat.intelligence: 4,
      PrimaryStat.constitution: 6,
    },
    [selectByTag("ferathrope", 2), selectByTag("common", 1)],
  ),
  // Const ++ Str + myst - per - char -
  "vampire": Origin(
    {
      PrimaryStat.mysticism: 5,
      PrimaryStat.strength: 5,
      PrimaryStat.speed: 6,
      PrimaryStat.perception: 6,
      PrimaryStat.intelligence: 6,
      PrimaryStat.constitution: 5,
    },
    [selectByTag("vampire", 1), selectByTag("common", 1)],
  ),
  // Const ++ Str + myst - per - char -
  "witch": Origin(
    {
      PrimaryStat.mysticism: 7,
      PrimaryStat.strength: 3,
      PrimaryStat.speed: 4,
      PrimaryStat.perception: 6,
      PrimaryStat.intelligence: 5,
      PrimaryStat.constitution: 3,
    },
    [selectByTag("witch", 1), selectByTag("common", 1)],
  ),
  // Const ++ Str + myst - per - char -
  "blight_weaver": Origin(
    {
      PrimaryStat.mysticism: 7,
      PrimaryStat.strength: 4,
      PrimaryStat.speed: 3,
      PrimaryStat.perception: 5,
      PrimaryStat.intelligence: 7,
      PrimaryStat.constitution: 3,
    },
    [selectByTag("blight_weaver", 1), selectByTag("blight_weaver", 1), selectByTag("common", 1)],
  ),
  // Const ++ Str + myst - per - char -
  "hunter": Origin(
    {
      PrimaryStat.mysticism: 4,
      PrimaryStat.strength: 4,
      PrimaryStat.speed: 5,
      PrimaryStat.perception: 6,
      PrimaryStat.intelligence: 4,
      PrimaryStat.constitution: 4,
    },
    [selectByTag("hunter_orden", 1), selectByTag("hunter", 1), selectByTag("common", 2)],
  ),
};

class Origin {
  final Map<String, int> primaryStats;
  final List<SigilSelection> sigilSelection;
  final List<String>? actions;
  final List<String>? dice;

  const Origin(this.primaryStats, this.sigilSelection, {this.actions = const [], this.dice = const []});
}

class SigilSelection {
  final List<String> sigilsToChooseFrom;
  final int howMany;

  const SigilSelection(this.sigilsToChooseFrom, this.howMany);
}

SigilSelection selectByTag(String tag, int howMany) {
  List<String> selection = sigils.values.where((sigil) => sigil.tag == tag).map((sigil) => sigil.id).toList();

  return SigilSelection(selection, howMany);
}
