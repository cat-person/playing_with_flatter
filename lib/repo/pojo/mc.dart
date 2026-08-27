import 'origins.dart';

class MC {
  final String originId;
  final List<String> sigils;

  MC({this.originId = 'none', this.sigils = const []});

  MC copyWith({String? originId, List<String>? sigils}) {
    return MC(
      originId: originId ?? this.originId,
      sigils: sigils ?? this.sigils,
    );
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
