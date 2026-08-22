import 'sigil.dart';

class Hero {
  Sigil origin;
  List<Sigil> sigils;

  Hero(this.origin, this.sigils);

  Map<String, int> getStats() {
    Map<String, int> result = {};

    for (var sigil in sigils) {}

    return result;
  }
}

abstract class Equipment {}
