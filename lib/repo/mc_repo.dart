import 'package:snd/event_processor/event_processor.dart';

import 'pojo/mc.dart';
import 'package:snd/event_processor/event.dart';

class MCRepo extends EventProcessor<MC> {
  MCRepo({super.proxy}) : super(MC());

  @override
  bool internalEventHandler(Event event) {
    switch (event.id) {
      case "origin_selected":
        update(latestState.copyWith(origin: event.params["origin_id"]));
        return true;
      case "sigil_selected":
        String sigilId = event.params["sigil_id"];
        int sigilIdIdx = latestState.sigils.indexOf(sigilId);
        List<String> updatedSigils = (sigilIdIdx == -1)
            ? [...latestState.sigils, sigilId]
            : [
                ...latestState.sigils.getRange(0, sigilIdIdx),
                ...latestState.sigils.getRange(
                  sigilIdIdx + 1,
                  latestState.sigils.length,
                ),
              ];

        update(latestState.copyWith(sigils: updatedSigils));
        return true;
    }
    return false;
  }
}
