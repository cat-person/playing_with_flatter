import 'base/repo.dart';
import 'pojo/sigil.dart';
import 'dart:async';
import 'package:snd/event.dart';

class SigilsRepo extends Repo<Map<String, Sigil>> {
  SigilsRepo() : super(sigils, StreamController<Map<String, Sigil>>());

  @override
  bool eventHandler(Event event) {
    return false;
  }
}
