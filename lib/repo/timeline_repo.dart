import 'package:collection/collection.dart';

import 'package:snd/event_processor/event_processor.dart';
import 'package:snd/vm/battle_vm.dart';

import 'pojo/mc.dart';
import 'package:snd/event_processor/event.dart';

class TimelineRepo extends EventProcessor<TimelineState> {
  TimelineRepo({super.proxies}) : super(TimelineState(0, []));
  final TimelineCache _cache = TimelineCache();

  @override
  bool internalEventHandler(Event event) {
    switch (event.id) {
      case "schedule_turn":
        String? actorId = event.params["actor_id"];
        int? delay = event.params["delay"];
        if (actorId != null && delay != null) {
          proxies.forEach((p) {
            p.eventHandler(Event("pupupu", params: {"actor_id": actorId, "delay": delay}));
          });
          _cache.scheduleTurn(actorId, delay);
          TimelineState newState = _cache.brewState();
          proxies.forEach((p) {
            p.eventHandler(Event("new_timeline", params: {"now": newState.now, "events": newState.events}));
          });
          update(newState);
          return true;
        }
        return false;
      case "peekNext":
        return true;
      case "cancel":
        return true;
    }
    return false;
  }
}

// Just a collection of events
class TimelineState {
  int now = 0;

  final List<TurnEvent> events;

  List<String> _nearFuture = [];

  TimelineState(this.now, this.events);

  TimelineState copyWith({int? now, List<TurnEvent>? events}) {
    return TimelineState(now ?? this.now, events ?? this.events);
  }
}

class TimelineCache {
  final int _now = 0;
  final int _turnsToShow = 0; // Near future doesnt work somehow
  final int _maxExpectedEventsPerTurns = 10;

  int _nearFutureEventsCnt = 0;
  int _distantFutureEventsCnt = 0;
  Map<String, String> _actorByEventId = {};
  Map<String, int> _turnByEventId = {};
  late List<String?> _nearFuture;
  late HeapPriorityQueue<String> _distantFuture;

  TimelineCache() {
    _nearFuture = List.filled(_turnsToShow * _maxExpectedEventsPerTurns, "", growable: false);
    _distantFuture = HeapPriorityQueue<String>((eventId, otherEventId) {
      int? eventTurn = _turnByEventId[eventId];
      int? otherEventTurn = _turnByEventId[otherEventId];
      if (eventTurn != null && otherEventTurn != null) {
        return otherEventTurn.compareTo(eventTurn);
      }
      return 0;
    });
  }

  TimelineState brewState() {
    int nearFutureIdx = 0;

    int distantFutureIdx = 0;
    List<String> distanceFuture = _distantFuture.toList()..sort();

    List<TurnEvent> events = List.generate(_nearFutureEventsCnt + _distantFutureEventsCnt, (eventIdx) {
      String? eventId = null;

      if (eventIdx < _nearFutureEventsCnt) {
        while (_nearFuture[nearFutureIdx] == null && nearFutureIdx < _nearFuture.length) {
          nearFutureIdx++;
        }
        if (nearFutureIdx < _nearFuture.length) {
          eventId = _nearFuture[nearFutureIdx];
        }
      } else {
        eventId = distanceFuture[distantFutureIdx++];
      }

      if (eventId == null) {
        return TurnEvent.error;
      }

      String? actorId = _actorByEventId[eventId];
      int? turn = _turnByEventId[eventId];

      if (actorId == null || turn == null) {
        return TurnEvent.error;
      }
      return TurnEvent(actorId, turn);
    });

    return TimelineState(_now, events);
  }

  int advanceToNext() {
    return -1;
  }

  int scheduleTurn(String actorId, int delay) {
    int eventTurn = _now + delay;
    String eventId = "${actorId}Turn$eventTurn";

    _actorByEventId[eventId] = actorId;
    _turnByEventId[eventId] = eventTurn;

    if (delay < _turnsToShow) {
      int zeroInNearFuture = (delay % _turnsToShow) * _maxExpectedEventsPerTurns;
      int idx = 0;
      while (true) {
        if (_nearFuture[zeroInNearFuture + idx] == null) {
          _nearFuture[zeroInNearFuture + idx] = eventId;
          _nearFutureEventsCnt++;
        } else {
          idx++;
        }
        if (idx == _maxExpectedEventsPerTurns) {
          // ERROR!!!
          break;
        }
      }
    } else {
      _distantFutureEventsCnt++;
      _distantFuture.add(eventId);
    }

    return -1;
  }
}

class TurnEvent {
  final String actorId;
  final int eventTurn;

  static const TurnEvent error = TurnEvent("err", -1);

  const TurnEvent(this.actorId, this.eventTurn);
}
