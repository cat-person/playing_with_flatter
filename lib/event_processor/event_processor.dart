import 'dart:async';
import 'event.dart';

abstract class EventProcessor<TState> {
  final StreamController<TState> _streamController = StreamController<TState>();
  TState _latestState;
  final EventProcessor? proxy;

  EventProcessor(this._latestState, {this.proxy}) {
    _streamController.add(_latestState);
  }

  bool eventHandler(Event event) {
    proxy?.eventHandler(event);
    return internalEventHandler(event);
  }

  bool internalEventHandler(Event event);

  Stream<TState> get stream => _streamController.stream;
  TState get latestState => _latestState;

  void update(TState newState) {
    _streamController.add(newState);
    _latestState = newState;
  }
}
