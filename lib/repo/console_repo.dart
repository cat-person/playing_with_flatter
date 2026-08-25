import 'base/repo.dart';
import 'pojo/origins.dart';
import 'dart:async';

class EventInterceptorRepo() extends Repo<List<Entry<String, Map<String, dynamic>>>, OriginsEvent> {


  EventInterceptorRepo()
    : super(defaultOrigins, StreamController<Map<String, Origin>>());

  @override
  bool eventHandler(OriginsEvent event) {
    latestState[eve]
    update()

  }
}

sealed class OriginsEvent {}
