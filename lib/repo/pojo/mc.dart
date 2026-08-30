import 'origins.dart';

class MC {
  final String originId;
  final List<String> sigils;
  final List<String> actions;

  MC({this.originId = 'none', this.sigils = const [], this.actions = const ["punch", "heal"]});

  MC copyWith({String? originId, List<String>? sigils, List<String>? actions}) {
    return MC(originId: originId ?? this.originId, sigils: sigils ?? this.sigils, actions: actions ?? this.actions);
  }

  Map<String, int> get stats {
    Origin? origin = defaultOrigins[originId];
    if (origin != null) {
      Map<String, int> originStats = origin.primaryStats;
      return originStats;
    } else {
      return {};
    }
  }
}
