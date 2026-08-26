import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:snd/event_processor/event_processor.dart';
import 'package:snd/event_processor/event.dart';

class ConsoleVM extends EventProcessor<List<TextSpan>> {
  final EventProcessor<List<Event>> consoleRepo;
  ConsoleVM(this.consoleRepo)
    : super([
        TextSpan(text: "Halo"),
        TextSpan(text: "Bububu"),
        TextSpan(text: "@.@"),
      ]) {
    consoleRepo.stream.listen(
      (data) => update(data.map((item) => TextSpan(text: item.id)).toList()),
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

class MyConsoleWidget extends StatelessWidget {
  final Stream<List<TextSpan>> stream;
  final List<TextSpan> initialData;
  final bool Function(Event event) eventHandler;

  const MyConsoleWidget(
    this.stream,
    this.initialData,
    this.eventHandler, {
    super.key,
  });

  @override
  build(BuildContext context) {
    return StreamBuilder<List<TextSpan>>(
      stream: stream,
      initialData: initialData,
      builder: (BuildContext context, AsyncSnapshot<List<TextSpan>> snap) {
        List<TextSpan>? entries = snap.data;
        return SizedBox(
          height: 200,
          child: (entries != null && entries.isNotEmpty)
              ? ListView.builder(
                  padding: const EdgeInsets.all(8),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    final TextSpan span = entries[index];
                    return LineListItem(span);
                  },
                )
              : Text("Can't read entries"),
        );
      },
    );
  }
}

class LineListItem extends StatelessWidget {
  final TextSpan span;
  const LineListItem(this.span, {super.key});

  @override
  build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Text("Privet ${span.text}", style: textTheme.labelMedium);
  }
}
