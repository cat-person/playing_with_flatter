import 'package:flutter/material.dart';
import 'package:snd/event_processor/event_processor.dart';

import 'package:snd/repo/pojo/origins.dart';
import 'package:snd/repo/pojo/mc.dart';
import 'package:snd/repo/pojo/sigil.dart';

import 'package:snd/ui/base/page.dart';
import 'package:snd/vm/character_creation_vm.dart';
import 'package:snd/event_processor/event.dart';
import 'mc_widget.dart';

class CharacterCreationPage extends MyPage<CharacterCreationState> {
  const CharacterCreationPage({super.key, required super.stream, required super.initialData, required super.eventHandler});

  @override
  Widget build(BuildContext context, AsyncSnapshot<CharacterCreationState> snap) {
    CharacterCreationState? data = snap.data;

    if (data == null) {
      return Text("NO DATA");
    }

    final MC mc = data.mc;
    final List<SigilSelection> sigilSelection = data.sigilSelection;
    final Map<String, Origin> originCollection = data.originColleciton;
    // final Map<String, Sigil> sigilCollection = data.sigilCollection;
    final List<String> selectebleOriginsId = originCollection.keys.toList();

    return Column(
      children: [
        MCWidget(mc, eventHandler),
        SizedBox(height: 4),
        SizedBox(
          height: 72,
          child: Center(
            child: Container(
              color: Colors.red,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: selectebleOriginsId.length,
                itemBuilder: (BuildContext context, int index) {
                  final String originId = selectebleOriginsId[index];
                  final Origin? origin = originCollection[originId];
                  if (originId.isNotEmpty && origin != null) {
                    return OriginListItem(
                      originId: originId,
                      origin: origin,
                      selected: originId == mc.originId,
                      eventHandler: eventHandler,
                    );
                  }
                  return Text("Can't read entity with index: $index");
                },
              ),
            ),
          ),
        ),

        SizedBox(height: 4), // Add spacing
        Center(
          child: SizedBox(
            height: 240,
            child: Container(
              color: Colors.deepPurple,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: sigilSelection.length,
                itemBuilder: (BuildContext context, int index) {
                  return SigilSelectionItem(sigilSelection: sigilSelection[index], selectedSigils: mc.sigils, eventHandler: eventHandler);
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
  final bool selected;
  final bool Function(Event event) eventHandler;

  const OriginListItem({super.key, required this.originId, required this.origin, required this.selected, required this.eventHandler});

  @override
  build(BuildContext context) {
    // List<String> primaryStatIds = origin.primaryStats.keys.toList();
    final textTheme = Theme.of(context).textTheme;
    return UnconstrainedBox(
      child: SizedBox(
        height: 60,
        width: 200,
        child: GestureDetector(
          onTap: () {
            eventHandler(Event("origin_selected", params: {"origin_id": originId}));
          },
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 2,
            color: selected ? Colors.blue : Colors.blueGrey,
            child: Center(
              child: Text(originId, style: textTheme.titleLarge?.copyWith(color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }
}

class SigilSelectionItem extends StatelessWidget {
  final List<String> selectedSigils;
  final SigilSelection sigilSelection;
  final bool Function(Event event) eventHandler;

  const SigilSelectionItem({super.key, required this.selectedSigils, required this.sigilSelection, required this.eventHandler});

  @override
  build(BuildContext context) {
    // List<String> primaryStatIds = origin.primaryStats.keys.toList();
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 80,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: sigilSelection.sigilsToChooseFrom.length,
        itemBuilder: (BuildContext context, int index) {
          final String sigilId = sigilSelection.sigilsToChooseFrom[index];
          return SizedBox(
            width: 200,
            child: GestureDetector(
              onTap: () {
                eventHandler(Event("sigil_selected", params: {"sigil_id": sigilId}));
              },
              child: Card(
                color: selectedSigils.contains(sigilId) ? Colors.deepOrange : Colors.grey,
                child: Center(child: Text(sigilId, style: textTheme.titleLarge)),
              ),
            ),
          );
        },
      ),
    );
  }
}
