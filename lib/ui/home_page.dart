import 'package:flutter/material.dart';
import 'package:snd/repo/pojo/origins.dart';
import 'package:snd/repo/pojo/sigil.dart';
import 'package:snd/vm/base/vm.dart';
import 'base/page.dart';
import 'package:snd/vm/main/main_vm.dart';

class HomePage extends MyPage<MainState> {
  const HomePage({
    super.key,
    required super.stream,
    required super.initialData,
    required super.eventHandler,
  });

  @override
  Widget build(BuildContext context, AsyncSnapshot<MainState> snap) {
    final List<String>? originEntries = snap.data?.origins.keys.toList();
    final List<String>? sigilEntries = snap.data?.sigils.keys.toList();
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        SizedBox(height: 12), // Add spacing
        Text(
          "Selected origin: ${snap.data?.selectedOrigin}",
          style: textTheme.headlineLarge,
        ),
        SizedBox(height: 12), // Add spacing
        SizedBox(
          height: 220,
          child: Center(
            child: originEntries == null || originEntries.isEmpty
                ? Text("Cant read origins")
                : Container(
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
            child: sigilEntries == null || sigilEntries.isEmpty
                ? Text("Cant read sigils")
                : Container(
                    color: Colors.orange,
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
                          return SigilGridItem(sigilId: sigilId, sigil: sigil);
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

class OriginListItem extends StatelessWidget {
  final String originId;
  final Origin origin;
  final bool Function(VMEvent event) eventHandler;

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
            eventHandler(
              VMEvent("select_origin", params: {"selected_origin": originId}),
            );
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

class SigilGridItem extends StatelessWidget {
  final String sigilId;
  final Sigil sigil;
  // final bool Function(SelectOriginE event) eventHandler;

  const SigilGridItem({super.key, required this.sigilId, required this.sigil});

  @override
  build(BuildContext context) {
    // List<String> primaryStatIds = origin.primaryStats.keys.toList();
    final textTheme = Theme.of(context).textTheme;
    return UnconstrainedBox(
      child: SizedBox(
        height: 100,
        width: 100,
        child: GestureDetector(
          onTap: () {},
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            color: Colors.grey,
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
