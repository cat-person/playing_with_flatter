import 'stats.dart';

Map<String, Origin> defaultOrigins = {
  // Const ++ Str + myst - per - char -
  "flash_construct": Origin(
    {
      PrimaryStat.mysticism: 4,
      PrimaryStat.strength: 6,
      PrimaryStat.speed: 5,
      PrimaryStat.perception: 4,
      PrimaryStat.intelligence: 4,
      PrimaryStat.constitution: 6,
    },
    [SigilSelection([], 2)],
  ),
  // Const ++ Str + myst - per - char -
  "ferathrope": Origin(
    {
      PrimaryStat.mysticism: 4,
      PrimaryStat.strength: 6,
      PrimaryStat.speed: 5,
      PrimaryStat.perception: 4,
      PrimaryStat.intelligence: 4,
      PrimaryStat.constitution: 6,
    },
    [SigilSelection([], 1), SigilSelection([], 2)],
  ),
  // Const ++ Str + myst - per - char -
  "vampire": Origin(
    {
      PrimaryStat.mysticism: 4,
      PrimaryStat.strength: 6,
      PrimaryStat.speed: 5,
      PrimaryStat.perception: 4,
      PrimaryStat.intelligence: 4,
      PrimaryStat.constitution: 6,
    },
    [SigilSelection([], 2), SigilSelection([], 2)],
  ),
  // Const ++ Str + myst - per - char -
  "witch": Origin(
    {
      PrimaryStat.mysticism: 4,
      PrimaryStat.strength: 6,
      PrimaryStat.speed: 5,
      PrimaryStat.perception: 4,
      PrimaryStat.intelligence: 4,
      PrimaryStat.constitution: 6,
    },
    [SigilSelection([], 1), SigilSelection([], 2)],
  ),
  // Const ++ Str + myst - per - char -
  "blight_weaver": Origin(
    {
      PrimaryStat.mysticism: 4,
      PrimaryStat.strength: 6,
      PrimaryStat.speed: 5,
      PrimaryStat.perception: 4,
      PrimaryStat.intelligence: 4,
      PrimaryStat.constitution: 6,
    },
    [SigilSelection([], 1), SigilSelection([], 1), SigilSelection([], 2)],
  ),
  // Const ++ Str + myst - per - char -
  "hunter": Origin(
    {
      PrimaryStat.mysticism: 4,
      PrimaryStat.strength: 6,
      PrimaryStat.speed: 5,
      PrimaryStat.perception: 4,
      PrimaryStat.intelligence: 4,
      PrimaryStat.constitution: 6,
    },
    [SigilSelection([], 1), SigilSelection([], 2), SigilSelection([], 2)],
  ),
};

class Origin {
  final Map<String, int> primaryStats;
  final List<SigilSelection> chooseFrom;
  final List<String>? actions;
  final List<String>? dice;

  const Origin(
    this.primaryStats,
    this.chooseFrom, {
    this.actions = const [],
    this.dice = const [],
  });
}

class SigilSelection {
  final List<String> sigilsToChooseFrom;
  final int howMany;

  const SigilSelection(this.sigilsToChooseFrom, this.howMany);
}
