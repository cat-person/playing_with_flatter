import 'package:flutter/material.dart';
import 'my_page.dart';
import 'package:snd/vm/main/main_vm.dart';

class HomePage extends MyPage<MainState, MainEvent> {
  const HomePage({
    super.key,
    required super.stream,
    required super.initialData,
    required super.eventHandler,
  });

  @override
  Widget build(BuildContext context, AsyncSnapshot<MainState> snap) {
    final List<String>? entries = snap.data?.origins.keys.toList();

    if (entries != null) {
      return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 50,
            child: Center(child: Text('Entry ${entries[index]}')),
          );
        },
      );
    }
    return Text("Cant read entries");
  }
}
