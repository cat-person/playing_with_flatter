import 'package:flutter/material.dart';
import 'package:snd/event_processor/event_processor.dart';
import 'package:snd/event_processor/event.dart';
import 'package:snd/repo/console_repo.dart';

// class ConsoleVM extends EventProcessor<List<TextSpan>> {
//   final EventProcessor<List<Event>> consoleRepo;
//   ConsoleVM(this.consoleRepo) : super([TextSpan(text: "Halo"), TextSpan(text: "Bububu"), TextSpan(text: "@.@")]) {
//     consoleRepo.stream.listen(
//       (data) => update(
//         data
//             .map(
//               (item) => TextSpan(
//                 children: [
//                   TextSpan(
//                     text: "${item.id}: ",
//                     style: TextStyle(color: Colors.lightBlue, decoration: TextDecoration.none, fontSize: 16),
//                   ),
//                   TextSpan(
//                     text: "${item.params}",
//                     style: TextStyle(color: Colors.lightGreen, decoration: TextDecoration.none, fontSize: 16),
//                   ),
//                 ],
//               ),
//             )
//             .toList(),
//       ),
//       onError: (error) => print('Error: $error'),
//       onDone: () => print('Stream closed'),
//       cancelOnError: false,
//     );
//   }
//
//   @override
//   bool internalEventHandler(Event event) {
//     return true;
//   }
// }

class ConsoleVM extends EventProcessor<ConsoleState> {
  final ConsoleRepo consoleRepo;

  ConsoleVM(this.consoleRepo) : super(ConsoleState("", consoleRepo.latestState.map(eventToTextSpan).toList())) {
    consoleRepo.stream.listen(
      (data) => update(latestState.copyWith(consoleOutput: data.map(eventToTextSpan).toList())),
      onError: (error) => print('Error: $error'),
      onDone: () => print('Stream closed'),
      cancelOnError: false,
    );
  }

  @override
  bool internalEventHandler(Event event) {
    return true;
  }
}

class ConsoleState {
  final String consoleInput;
  final List<TextSpan> consoleOutput;

  ConsoleState(this.consoleInput, this.consoleOutput);

  ConsoleState copyWith({String? consoleInput, List<TextSpan>? consoleOutput}) {
    return ConsoleState(consoleInput ?? this.consoleInput, consoleOutput ?? this.consoleOutput);
  }
}

TextSpan eventToTextSpan(Event event) {
  return TextSpan(
    children: [
      TextSpan(
        text: "${event.id}: ",
        style: TextStyle(color: Colors.lightBlue, decoration: TextDecoration.none, fontSize: 16),
      ),
      TextSpan(
        text: "${event.params}",
        style: TextStyle(color: Colors.lightGreen, decoration: TextDecoration.none, fontSize: 16),
      ),
    ],
  );
}
