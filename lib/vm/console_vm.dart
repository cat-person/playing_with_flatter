import 'package:flutter/material.dart';
import 'package:snd/event_processor/event_processor.dart';
import 'package:snd/event_processor/event.dart';
import 'package:snd/repo/console_repo.dart';

class ConsoleVM extends EventProcessor<ConsoleState> {
  final ConsoleRepo consoleRepo;
  static final TextEditingController _consoleInputController = TextEditingController();

  ConsoleVM(this.consoleRepo) : super(ConsoleState(_consoleInputController, consoleRepo.latestState.map(eventToTextSpan).toList())) {
    _consoleInputController.addListener(() {
      // final String currentText = _consoleInputController.text;
      // eventHandler(Event("exec", params: {"command_text": currentText}));
      //   _consoleInputController.value = _consoleInputController.value.copyWith(text: '', selection: TextSelection.collapsed(offset: 0));
      //   eventHandler(Event("exec", params: {"command_text": currentText.replaceAll('\n', '')}));
    });

    consoleRepo.stream.listen(
      (data) => update(latestState.copyWith(consoleOutput: data.map(eventToTextSpan).toList())),
      onError: (error) => print('Error: $error'),
      onDone: () => print('Stream closed'),
      cancelOnError: false,
    );
  }

  @override
  bool internalEventHandler(Event event) {
    switch (event.id) {
      case "exec":
        consoleRepo.eventHandler(Event("exec", params: {"command_text": _consoleInputController.text}));
        _consoleInputController.value = _consoleInputController.value.copyWith(text: '', selection: TextSelection.collapsed(offset: 0));
        return true;
      default:
        return consoleRepo.eventHandler(event);
    }
  }
}

class ConsoleState {
  final List<TextSpan> consoleOutput;
  final TextEditingController consoleInputController;

  ConsoleState(this.consoleInputController, this.consoleOutput);

  ConsoleState copyWith({List<TextSpan>? consoleOutput}) {
    return ConsoleState(consoleInputController, consoleOutput ?? this.consoleOutput);
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

bool isAllowedKey(int keyId) {
  return keyId.charInRange('a', 'z') ||
      keyId.charInRange('A', 'Z') ||
      keyId.charInRange('0', '9') ||
      keyId.charInSet([' ', ',', '.', ':', '{', '}', '_']) ||
      keyId == 8 || // Backspace
      keyId == 4294967304 || // Backspace 0.0
      keyId == 4294968066 || // Arrow left
      keyId == 4294968067; // Arrow right
}

extension IntRangeExtension on int {
  bool charInRange(String min, String max) {
    return min.codeUnitAt(0) <= this && this <= max.codeUnitAt(0);
  }

  bool charInSet(List<String> chars) {
    return chars.any((char) => this == char.codeUnitAt(0));
  }
}
