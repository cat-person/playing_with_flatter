import 'package:snd/event_processor/event_processor.dart';
import 'package:snd/repo/origins_repo.dart';
import 'package:snd/repo/sigils_repo.dart';
import 'package:snd/event_processor/event.dart';
import '../../repo/pojo/origins.dart';
import '../../repo/pojo/sigil.dart';

class MainVM extends EventProcessor<MainState> {
  MainVM(OriginsRepo originsRepo, SigilsRepo sigilsRepo, {super.proxy})
    : super(
        MainState(
          origins: originsRepo.latestState,
          selectedOrigin: "",
          sigils: sigilsRepo.latestState,
        ),
      );

  @override
  bool internalEventHandler(Event event) {
    switch (event.id) {
      case "origin_selected":
        update(
          latestState.copyWith(
            selectedOrigin: event.params["origin_id"] as String,
          ),
        );
        return true;
      case "sigil_selected":
        String sigilId = event.params["sigil_id"] as String;

        int sigilIdIdx = latestState.selectedSigils.indexOf(sigilId);
        List<String> newSelectedSigils = (sigilIdIdx == -1)
            ? [...latestState.selectedSigils, sigilId]
            : [
                ...latestState.selectedSigils.getRange(0, sigilIdIdx),
                ...latestState.selectedSigils.getRange(
                  sigilIdIdx,
                  latestState.selectedSigils.length,
                ),
              ];
        update(latestState.copyWith(selectedSigils: newSelectedSigils));
        return true;
      default:
        return false;
    }
  }
}

class MainState {
  final Map<String, Origin> origins;
  final String selectedOrigin;
  final Map<String, Sigil> sigils;
  final List<String> selectedSigils;

  const MainState({
    required this.origins,
    required this.sigils,
    this.selectedOrigin = "none",
    this.selectedSigils = const [],
  });

  MainState copyWith({
    Map<String, Origin>? origins,
    Map<String, Sigil>? sigils,
    String? selectedOrigin,
    List<String>? selectedSigils,
  }) {
    return MainState(
      origins: origins ?? this.origins,
      sigils: sigils ?? this.sigils,
      selectedOrigin: selectedOrigin ?? this.selectedOrigin,
      selectedSigils: selectedSigils ?? this.selectedSigils,
    );
  }
}
