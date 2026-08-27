import 'package:flutter/material.dart';
import 'package:snd/repo/pojo/origins.dart';
import 'package:snd/repo/pojo/sigil.dart';
import 'package:snd/repo/pojo/mc.dart';
import 'base/page.dart';
import 'package:snd/vm/main/main_vm.dart';
import 'package:snd/event_processor/event.dart';

class HomePage extends MyPage<MainState> {
  const HomePage({
    super.key,
    required super.stream,
    required super.initialData,
    required super.eventHandler,
  });

  @override
  Widget build(BuildContext context, AsyncSnapshot<MainState> snap) {
    MainState? data = snap.data;

    if (data == null) {
      return Text("NO DATA");
    }
    final List<String> originEntries = data.origins.keys.toList();
    final List<String> sigilEntries = data.sigils.keys.toList();
    final MC mc = data.mc;

    return Column(
      children: [
        SizedBox(height: 12), // Add spacing
        MCWidget(mc),
        SizedBox(height: 12), // Add spacing
        SizedBox(
          height: 180,
          child: Center(
            child: Container(
              color: Colors.red,
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: originEntries.length,
                itemBuilder: (BuildContext context, int index) {
                  final String originId = originEntries[index];
                  final Origin? origin = snap.data?.origins[originId];
                  if (originId.isNotEmpty && origin != null) {
                    return OriginListItem(
                      originId: originId,
                      origin: origin,
                      selected: originId == mc.origin,
                      eventHandler: eventHandler,
                    );
                  }
                  return Text("Can't read entity with index: $index");
                },
              ),
            ),
          ),
        ),

        SizedBox(height: 12), // Add spacing
        Center(
          child: SizedBox(
            width: 1200,
            child: Container(
              color: Colors.deepPurple,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10, // Number of columns
                  // crossAxisSpacing: 10,
                  // mainAxisSpacing: 10,
                  childAspectRatio: 1.0, // Width/height ratio
                ),
                padding: const EdgeInsets.all(8),
                // scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: sigilEntries.length,
                itemBuilder: (BuildContext context, int index) {
                  final String sigilId = sigilEntries[index];
                  final Sigil? sigil = snap.data?.sigils[sigilId];
                  if (sigilId.isNotEmpty && sigil != null) {
                    return SigilGridItem(
                      sigilId: sigilId,
                      sigil: sigil,
                      selected: mc.sigils.contains(sigilId),
                      eventHandler: eventHandler,
                    );
                  }
                  return Text("Can't read entity with index: $index");
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MCWidget extends StatelessWidget {
  final MC mc;

  const MCWidget(this.mc, {super.key});

  @override
  build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 160,
      width: 1200,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.blue[900],
        child: Column(
          children: [
            Text(
              "Hero: ${mc.origin}",
              style: textTheme.titleLarge?.copyWith(color: Colors.red),
            ),
            Text(
              mc.sigils.join(', '),
              style: textTheme.titleSmall?.copyWith(color: Colors.deepOrange),
            ),
          ],
        ),
      ),
    );
  }
}

class OriginListItem extends StatelessWidget {
  final String originId;
  final Origin origin;
  final bool selected;
  final bool Function(Event event) eventHandler;

  const OriginListItem({
    super.key,
    required this.originId,
    required this.origin,
    required this.selected,
    required this.eventHandler,
  });

  @override
  build(BuildContext context) {
    List<String> primaryStatIds = origin.primaryStats.keys.toList();
    final textTheme = Theme.of(context).textTheme;
    return UnconstrainedBox(
      child: SizedBox(
        height: 160,
        width: 200,
        child: GestureDetector(
          onTap: () {
            eventHandler(
              Event("origin_selected", params: {"origin_id": originId}),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            color: selected ? Colors.blue : Colors.blueGrey,
            child: Column(
              children: [
                Text(originId, style: textTheme.headlineMedium),
                SizedBox(
                  height: 100,
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

class SigilGridItem extends StatelessWidget {
  final String sigilId;
  final Sigil sigil;
  final bool selected;
  final bool Function(Event event) eventHandler;

  const SigilGridItem({
    super.key,
    required this.sigilId,
    required this.sigil,
    required this.selected,
    required this.eventHandler,
  });

  @override
  build(BuildContext context) {
    // List<String> primaryStatIds = origin.primaryStats.keys.toList();
    final textTheme = Theme.of(context).textTheme;
    return UnconstrainedBox(
      child: SizedBox(
        height: 100,
        width: 100,
        child: GestureDetector(
          onTap: () {
            eventHandler(
              Event("sigil_selected", params: {"sigil_id": sigilId}),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: selected ? 4 : 2,
            color: selected ? Colors.orangeAccent : Colors.grey,
            child: Center(
              child: Text(
                sigilId,
                style: textTheme.labelLarge?.copyWith(
                  backgroundColor: Colors.lightBlueAccent,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
