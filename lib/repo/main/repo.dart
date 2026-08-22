import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../pojo/hero.dart';
import '../pojo/origins.dart';
import '../pojo/sigil.dart';

class MainRepo extends Bloc<MainRE, MainRS> {
  StreamController<Hero> userSC = StreamController<Hero>.broadcast();
  StreamController<Map<String, Sigil>> originSC =
      StreamController<Map<String, Sigil>>.broadcast();

  MainRepo() : super(MainRS()) {
    Hero defaultHero = Hero(Sigil([], [], []), []);
    userSC.add(defaultHero);
    originSC.add(defaultOrigins);
  }

  Stream<Hero> getHeroStream() {
    return userSC.stream;
  }

  Stream<Map<String, Sigil>> getOriginStream() {
    return originSC.stream;
  }
}

class MainRS {}

sealed class MainRE {}

class Pupupu extends MainRE {}

class Uwu extends MainRE {}
