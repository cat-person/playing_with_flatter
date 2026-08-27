import 'dart:convert';
import 'package:snd/event_processor/event_processor.dart';

import 'pojo/origins.dart';
import 'package:snd/event_processor/event.dart';

class OriginsRepo extends EventProcessor<Map<String, Origin>> {
  // final OriginsReader reader = OriginsReader("origins.json");
  OriginsRepo({super.proxy}) : super(defaultOrigins) {
    // reader.eventHandler(Event("load"));
  }

  @override
  bool internalEventHandler(Event event) {
    return false;
  }
}

// class OriginsReader extends EventProcessor<Map<String, Origin>> {
//   final String filepath;

//   OriginsReader(this.filepath, {super.proxy}) : super({});

//   @override
//   bool internalEventHandler(Event event) {
    // try {
    //     // Read file
    //     String jsonString = await File('data.json').readAsString();
    //     Map<String, dynamic>  data = jsonDecode(jsonString);
    //     // Map<String, Origin>
    //     update(data);
    //   } catch (e) {
    //     print('Error reading file: $e');
    //     return false;
    //   }
//     return false;
//   }
// }
