import 'sigil.dart';
import 'stats.dart';

Map<String, Origin> defaultOrigins = {
  // Const ++ Str + myst - per - char -
  "flash_construct": Origin({
    PrimaryStat.mysticism: 4,
    PrimaryStat.strength: 6,
    PrimaryStat.speed: 5,
    PrimaryStat.perception: 4,
    PrimaryStat.charisma: 4,
    PrimaryStat.constitution: 6,
  }, {}),
  // Const ++ Str + myst - per - char -
  "ferathrope": Origin({
    PrimaryStat.mysticism: 4,
    PrimaryStat.strength: 6,
    PrimaryStat.speed: 5,
    PrimaryStat.perception: 4,
    PrimaryStat.charisma: 4,
    PrimaryStat.constitution: 6,
  }, {}),
  // Const ++ Str + myst - per - char -
  "vampire": Origin({
    PrimaryStat.mysticism: 4,
    PrimaryStat.strength: 6,
    PrimaryStat.speed: 5,
    PrimaryStat.perception: 4,
    PrimaryStat.charisma: 4,
    PrimaryStat.constitution: 6,
  }, {}),
  // Const ++ Str + myst - per - char -
  "witch": Origin({
    PrimaryStat.mysticism: 4,
    PrimaryStat.strength: 6,
    PrimaryStat.speed: 5,
    PrimaryStat.perception: 4,
    PrimaryStat.charisma: 4,
    PrimaryStat.constitution: 6,
  }, {}),
  // Const ++ Str + myst - per - char -
  "blight_weaver": Origin({
    PrimaryStat.mysticism: 4,
    PrimaryStat.strength: 6,
    PrimaryStat.speed: 5,
    PrimaryStat.perception: 4,
    PrimaryStat.charisma: 4,
    PrimaryStat.constitution: 6,
  }, {}),
  // Const ++ Str + myst - per - char -
  "hunter": Origin({
    PrimaryStat.mysticism: 4,
    PrimaryStat.strength: 6,
    PrimaryStat.speed: 5,
    PrimaryStat.perception: 4,
    PrimaryStat.charisma: 4,
    PrimaryStat.constitution: 6,
  }, {}),
};

class Origin {
  final Map<String, int> primaryStats;
  final Map<String, Sigil> sigils;

  Origin(this.primaryStats, this.sigils);
}
