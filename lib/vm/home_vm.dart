import 'package:snd/event_processor/event_processor.dart';
import 'package:snd/event_processor/event.dart';

class HomeVM extends EventProcessor<String> {
  HomeVM({super.proxies}) : super("Uwu");

  @override
  bool internalEventHandler(Event event) {
    return false;
  }
}
