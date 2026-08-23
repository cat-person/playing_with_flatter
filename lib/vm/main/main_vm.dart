import 'dart:async';
import 'package:snd/repo/origins.dart';

import '../base/vm.dart';
import '../../repo/pojo/origins.dart';

class MainVM extends VM<MainState, MainEvent> {
  MainVM(OriginsRepo originsRepo)
    : super(
        MainState(origins: originsRepo.latestState, selectedOrigin: ""),
        StreamController<MainState>(),
      );

  @override
  bool eventHandler(MainEvent event) {
    switch (event) {
      case SelectOriginE(selectedOrigin: final selectedOrigin):
        update(latestState.copyWith(selectedOrigin: selectedOrigin));
        return true;
    }
  }
}

class MainState {
  final Map<String, Origin> origins;
  final String selectedOrigin;

  const MainState({required this.origins, required this.selectedOrigin});

  MainState copyWith({Map<String, Origin>? origins, String? selectedOrigin}) {
    return MainState(
      origins: origins ?? this.origins,
      selectedOrigin: selectedOrigin ?? this.selectedOrigin,
    );
  }
}

sealed class MainEvent {}

class SelectOriginE extends MainEvent {
  final String selectedOrigin;

  SelectOriginE(this.selectedOrigin);
}
