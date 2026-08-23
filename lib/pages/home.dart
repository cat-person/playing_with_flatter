import 'package:flutter/material.dart';
import 'package:snd/repo/pojo/origins.dart';
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
          final String originId = entries[index];
          final Origin? origin = snap.data?.origins[originId];
          if (originId.isNotEmpty && origin != null) {
            return OriginListItem(originId: originId, origin: origin);
          }
          return Text("Can't read entity with index: $index");
        },
      );
    }
    return Text("Cant read entries");
  }
}

class OriginListItem extends StatelessWidget {
  final String originId;
  final Origin origin;

  OriginListItem({super.key, required this.originId, required this.origin});

  @override
  build(BuildContext context) {
    return SizedBox(height: 80, child: Center(child: Text('Entry $originId')));
  }
}
