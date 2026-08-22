import 'dart:async';

abstract class Repo<TState, TEvent> {
  final StreamController<TState> streamController;

  Repo(this.streamController);

  bool eventHandler(TEvent event);
  Stream<TState> get stream => streamController.stream;
}
