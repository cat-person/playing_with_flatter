import 'pojo/sigil.dart';
import 'package:snd/event_processor/event_processor.dart';
import 'package:snd/event_processor/event.dart';

class SigilsRepo extends EventProcessor<Map<String, Sigil>> {
  SigilsRepo({super.proxy}) : super(sigils);

  @override
  bool internalEventHandler(Event event) {
    return false;
  }
}
