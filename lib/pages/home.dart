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
    final textTheme = Theme.of(context).textTheme;

    if (entries != null) {
      return Column(
        children: [
          Text(
            "Selected origin: ${snap.data?.selectedOrigin}",
            style: textTheme.labelLarge,
          ),
          SizedBox(
            height: 220,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              scrollDirection: Axis.horizontal,
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                final String originId = entries[index];
                final Origin? origin = snap.data?.origins[originId];
                if (originId.isNotEmpty && origin != null) {
                  return OriginListItem(
                    originId: originId,
                    origin: origin,
                    eventHandler: eventHandler,
                  );
                }
                return Text("Can't read entity with index: $index");
              },
            ),
          ),
        ],
      );
    }
    return Text("Cant read entries");
  }

  bool originEventHandler(SelectOriginE event) {
    return eventHandler(event);
  }
}

class OriginListItem extends StatelessWidget {
  final String originId;
  final Origin origin;
  final bool Function(SelectOriginE event) eventHandler;

  const OriginListItem({
    super.key,
    required this.originId,
    required this.origin,
    required this.eventHandler,
  });

  @override
  build(BuildContext context) {
    List<String> primaryStatIds = origin.primaryStats.keys.toList();
    final textTheme = Theme.of(context).textTheme;
    return UnconstrainedBox(
      child: SizedBox(
        height: 200,
        width: 200,
        child: GestureDetector(
          onTap: () {
            eventHandler(SelectOriginE(originId));
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            color: Colors.blue,
            child: Column(
              children: [
                Text(
                  originId,
                  style: textTheme.headlineMedium?.copyWith(
                    backgroundColor: Colors.green,
                  ),
                ),
                SizedBox(
                  height: 120,
                  width: 200,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: primaryStatIds.length,
                    itemBuilder: (BuildContext context, int index) {
                      final String statId = primaryStatIds[index];
                      final int? statValue = origin.primaryStats[statId];
                      if (statId.isNotEmpty && statValue != null) {
                        return Text(
                          "$statId: $statValue",
                          style: textTheme.labelMedium,
                        );
                      }
                      return Text("Can't read stat with index: $index");
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
