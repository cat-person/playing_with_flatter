class MC {
  final String origin;
  final List<String> sigils;

  MC({this.origin = 'none', this.sigils = const []});

  MC copyWith({String? origin, List<String>? sigils}) {
    return MC(origin: origin ?? this.origin, sigils: sigils ?? this.sigils);
  }
}
