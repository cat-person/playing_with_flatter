import 'dart:async';

abstract class VM<TState> {
  final StreamController<TState> _streamController;
  TState _latestState;

  VM(this._latestState, this._streamController) {
    _streamController.add(_latestState);
  }

  bool eventHandler(VMEvent event);
  Stream<TState> get stream => _streamController.stream;
  TState get latestState => _latestState;

  void update(TState newState) {
    _streamController.add(newState);
    _latestState = newState;
  }
}

class VMEvent {
  final String id;
  final Map<String, dynamic> params;

  VMEvent(this.id, {this.params = const {}});
}
