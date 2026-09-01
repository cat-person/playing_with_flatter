import 'dart:async';
import 'event.dart';

abstract class EventProcessor<TState> {
  final StreamController<TState> _streamController = StreamController<TState>.broadcast();
  TState _latestState;
  final List<EventProcessor> proxies;

  EventProcessor(this._latestState, {this.proxies = const []}) {
    _streamController.add(_latestState);
  }

  bool eventHandler(Event event) {
    for (var proxy in proxies) {
      proxy.eventHandler(event);
    }
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
