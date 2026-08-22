import 'sigil.dart';
import 'stats.dart';

Map<String, Sigil> defaultOrigins = {
  // Const ++ Str + myst - per - char -
  "flash_construct": Sigil([
    Modifier(PrimaryStat.mysticism, 4, 4),
    Modifier(PrimaryStat.strength, 6, 8),
    Modifier(PrimaryStat.speed, 5, 6),
    Modifier(PrimaryStat.perception, 4, 4),
    Modifier(PrimaryStat.charisma, 4, 4),
    Modifier(PrimaryStat.constitution, 6, 10)
  ], [], []),
  // Const ++ Str + myst - per - char -
  "ferathrope": Sigil([
    Modifier(PrimaryStat.mysticism, 4, 4),
    Modifier(PrimaryStat.strength, 6, 8),
    Modifier(PrimaryStat.speed, 8, 8),
    Modifier(PrimaryStat.perception, 7, 8),
    Modifier(PrimaryStat.charisma, 4, 4),
    Modifier(PrimaryStat.constitution, 7, 8)
  ], [], [

    ]
  ),
  // Const ++ Str + myst - per - char -
  "vampire": Sigil([
    Modifier(PrimaryStat.mysticism, 7, 8),
    Modifier(PrimaryStat.strength, 6, 8),
    Modifier(PrimaryStat.speed, 5, 6),
    Modifier(PrimaryStat.perception, 6, 7),
    Modifier(PrimaryStat.charisma, 7, 8),
    Modifier(PrimaryStat.constitution, 4, 4)
  ], [], [

    ]
  ),
  // Const ++ Str + myst - per - char -
  "witch": Sigil([
    Modifier(PrimaryStat.mysticism, 7, 8),
    Modifier(PrimaryStat.strength, 6, 8),
    Modifier(PrimaryStat.speed, 5, 6),
    Modifier(PrimaryStat.perception, 7, 8),
    Modifier(PrimaryStat.charisma, 5, 6),
    Modifier(PrimaryStat.constitution, 4, 4)
  ], [], [

    ]
  ),
  // Const ++ Str + myst - per - char -
  "blight_weaver": Sigil([
    Modifier(PrimaryStat.mysticism, 7, 8),
    Modifier(PrimaryStat.strength, 5, 6),
    Modifier(PrimaryStat.speed, 4, 4),
    Modifier(PrimaryStat.perception, 7, 8),
    Modifier(PrimaryStat.charisma, 4, 4),
    Modifier(PrimaryStat.constitution, 3, 3)
  ], [], [

    ]
  ),
  // Const ++ Str + myst - per - char -
  "Hunter": Sigil([
    Modifier(PrimaryStat.mysticism, 4, 4),
    Modifier(PrimaryStat.strength, 6, 8),
    Modifier(PrimaryStat.speed, 8, 8),
    Modifier(PrimaryStat.perception, 7, 8),
    Modifier(PrimaryStat.charisma, 4, 4),
    Modifier(PrimaryStat.constitution, 7, 8)
  ], [], [

    ]
  )
};
