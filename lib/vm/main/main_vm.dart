import 'dart:async';
import 'event.dart';
import 'state.dart';
import '../base/vm.dart';

class MainVM extends VM<MainState, MainEvent> {
  MainVM() : super(StreamController<MainState>());

  @override
  bool eventHandler(MainEvent event) {
    switch (event) {
      case A():
        streamController.add(MainState("A"));
        return true;
      case B():
        streamController.add(MainState("B"));
        return true;
    }
  }
}
