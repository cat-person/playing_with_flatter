import 'package:flutter/material.dart';
import 'package:snd/event_processor/event.dart';
import 'package:snd/vm/console_vm.dart';
import 'dart:ui' as ui show BoxHeightStyle;

class MyConsoleWidget extends StreamBuilderBase<ConsoleState, AsyncSnapshot<ConsoleState>> {
  final ConsoleState initialData;
  final bool Function(Event event) eventHandler;
  final ScrollController scrollController = ScrollController();

  MyConsoleWidget(this.initialData, this.eventHandler, {required super.stream, super.key});

  @override
  build(BuildContext context, AsyncSnapshot<ConsoleState> snap) {
    ConsoleState? consoleState = snap.data;
    if (consoleState == null) {
      return Center(
        child: Text("PRIVET", style: TextStyle(color: Colors.white, fontSize: 16)),
      );
    } else {
      Future.delayed(Duration(milliseconds: 100), () {
        scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 200), curve: Curves.easeOut);
      });

      return Container(
        height: 240,
        color: Colors.black87,
        width: double.infinity,
        child: Column(
          children: [
            // SizedBox(height: 32),
            SizedBox(
              height: 212,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                controller: scrollController,
                shrinkWrap: true,
                itemCount: consoleState.consoleOutput.length,
                itemBuilder: (BuildContext context, int index) {
                  final TextSpan span = consoleState.consoleOutput[index];
                  return LineListItem(span);
                },
              ),
            ),
            Container(
              child: SizedBox(
                height: 24,
                child: Center(
                  child: Row(
                    children: [
                      SizedBox(width: 4),
                      SizedBox(
                        width: 12,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            ">",
                            style: TextStyle(color: Colors.lightBlue, decoration: TextDecoration.none, fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      Expanded(child: ConsoleInputWidget(consoleState.consoleInputController, eventHandler)),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 4),
          ],
        ),
      );
    }
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

class ConsoleInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool Function(Event event) eventHandler;
  const ConsoleInputWidget(this.controller, this.eventHandler, {super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 2, horizontal: 0),
      // Container(
      // height: 36,

      // alignment: Alignment.center,
      // color: Colors.blueGrey,
      child: TextField(
        cursorHeight: 16,
        selectionHeightStyle: ui.BoxHeightStyle.tight,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        controller: controller,
        onEditingComplete: () {
          eventHandler(Event("exec", params: {"command_text": controller.text}));
        },
        enableSuggestions: false,
        autocorrect: false,
        style: TextStyle(color: Colors.lightBlue, decoration: TextDecoration.none, fontSize: 16, height: 5),
      ),
    );
  }
}

class LineListItem extends StatelessWidget {
  final TextSpan span;
  const LineListItem(this.span, {super.key});

  @override
  build(BuildContext context) {
    return Padding(padding: EdgeInsetsGeometry.symmetric(vertical: 4, horizontal: 20), child: Text.rich(span));
  }
}
