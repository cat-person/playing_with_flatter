import 'base/repo.dart';
import 'pojo/sigil.dart';
import 'dart:async';

class SigilsRepo extends Repo<Map<String, Sigil>, SigilsEvent> {
  SigilsRepo() : super(sigils, StreamController<Map<String, Sigil>>());

  @override
  bool eventHandler(SigilsEvent event) {
    return false;
  }
}

sealed class SigilsEvent {}
