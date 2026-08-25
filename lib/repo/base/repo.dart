import 'dart:async';

abstract class Repo<TState, TEvent> {
  final StreamController<TState> _streamController;
  TState _latestState;

  Repo(this._latestState, this._streamController) {
    _streamController.add(_latestState);
  }

  bool eventHandler(TEvent event);
  Stream<TState> get stream => _streamController.stream;
  TState get latestState => _latestState;

  void update(TState newState) {
    _streamController.add(newState);
    _latestState = newState;
  }
}

class Event {}
