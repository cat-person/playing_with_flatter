import 'base/repo.dart';
import 'pojo/origins.dart';
import 'dart:async';
import 'package:snd/event.dart';

class OriginsRepo extends Repo<Map<String, Origin>> {
  OriginsRepo()
    : super(defaultOrigins, StreamController<Map<String, Origin>>());

  @override
  bool eventHandler(Event event) {
    return false;
  }
}
