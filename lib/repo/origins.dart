import 'base/repo.dart';
import 'pojo/origins.dart';
import 'dart:async';

class OriginsRepo extends Repo<Map<String, Origin>, OriginsEvent> {
  OriginsRepo()
    : super(defaultOrigins, StreamController<Map<String, Origin>>());

  @override
  bool eventHandler(OriginsEvent event) {
    return false;
  }
}

sealed class OriginsEvent {}
