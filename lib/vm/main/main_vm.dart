import 'dart:async';
import 'package:snd/repo/origins.dart';
import 'package:snd/repo/sigil.dart';

import '../base/vm.dart';
import '../../repo/pojo/origins.dart';
import '../../repo/pojo/sigil.dart';

class MainVM extends VM<MainState, MainEvent> {
  MainVM(OriginsRepo originsRepo, SigilsRepo sigilsRepo)
    : super(
        MainState(
          origins: originsRepo.latestState,
          selectedOrigin: "",
          sigils: sigilsRepo.latestState,
        ),
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
  final Map<String, Sigil> sigils;
  final String selectedOrigin;

  const MainState({
    required this.origins,
    required this.selectedOrigin,
    required this.sigils,
  });

  MainState copyWith({
    Map<String, Origin>? origins,
    String? selectedOrigin,
    Map<String, Sigil>? sigils,
  }) {
    return MainState(
      origins: origins ?? this.origins,
      selectedOrigin: selectedOrigin ?? this.selectedOrigin,
      sigils: sigils ?? this.sigils,
    );
  }
}

sealed class MainEvent {}

class SelectOriginE extends MainEvent {
  final String selectedOrigin;

  SelectOriginE(this.selectedOrigin);
}
