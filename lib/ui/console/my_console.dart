import 'package:flutter/material.dart';
import 'package:snd/event_processor/event.dart';
import 'package:snd/vm/console_vm.dart';

class MyConsoleWidget extends StreamBuilderBase<ConsoleState, AsyncSnapshot<ConsoleState>> {
  final ConsoleState initialData;
  final bool Function(Event event) eventHandler;

  const MyConsoleWidget(this.initialData, this.eventHandler, {required super.stream, super.key});

  @override
  build(BuildContext context, AsyncSnapshot<ConsoleState> snap) {
    ConsoleState consoleState = snap.data ?? ConsoleState("", []);
    return Container(
      height: 288,
      color: Colors.black87,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: 240,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: consoleState.consoleOutput.length,
              itemBuilder: (BuildContext context, int index) {
                final TextSpan span = consoleState.consoleOutput[index];
                return LineListItem(span);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 20, 0),
            child: Row(
              children: [
                SizedBox(
                  width: 12,
                  child: Text(
                    ">",
                    style: TextStyle(color: Colors.lightBlueAccent, decoration: TextDecoration.none, fontSize: 16),
                  ),
                ),
                SizedBox(width: 4),
                Expanded(child: ConsoleInput(consoleState.consoleInput, eventHandler)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  AsyncSnapshot<ConsoleState> initial() => AsyncSnapshot<ConsoleState>.withData(ConnectionState.none, initialData);

  @override
  AsyncSnapshot<ConsoleState> afterConnected(AsyncSnapshot<ConsoleState> current) => current.inState(ConnectionState.waiting);

  @override
  AsyncSnapshot<ConsoleState> afterData(AsyncSnapshot<ConsoleState> current, ConsoleState data) {
    return AsyncSnapshot<ConsoleState>.withData(ConnectionState.active, data);
  }

  @override
  AsyncSnapshot<ConsoleState> afterError(AsyncSnapshot<ConsoleState> current, Object error, StackTrace stackTrace) {
    return AsyncSnapshot<ConsoleState>.withError(ConnectionState.active, error, stackTrace);
  }

  @override
  AsyncSnapshot<ConsoleState> afterDone(AsyncSnapshot<ConsoleState> current) => current.inState(ConnectionState.done);

  @override
  AsyncSnapshot<ConsoleState> afterDisconnected(AsyncSnapshot<ConsoleState> current) => current.inState(ConnectionState.none);
}

class ConsoleInput extends StatelessWidget {
  final String value;
  final bool Function(Event event) eventHandler;

  const ConsoleInput(this.value, this.eventHandler, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.lightBlueAccent, decoration: TextDecoration.none, fontSize: 16),
      onSubmitted: (value) {
        eventHandler(Event("console_input", params: {"command": value}));
        value = "";
      },
    );
  }
}

class LineListItem extends StatelessWidget {
  final TextSpan span;
  const LineListItem(this.span, {super.key});

  @override
  build(BuildContext context) {
    return SizedBox(height: 24, child: Text.rich(span));
  }
}
