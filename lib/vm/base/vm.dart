import 'dart:async';

abstract class VM<TState, TEvent> {
  final StreamController<TState> streamController;

  VM(this.streamController);

  bool eventHandler(TEvent event);
  Stream<TState> get stream => streamController.stream;
}
