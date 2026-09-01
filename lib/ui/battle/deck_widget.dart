import 'package:flutter/material.dart';
import 'package:snd/repo/pojo/wound.dart';
import 'package:snd/event_processor/event.dart';

class DeckWidget extends StatelessWidget {
  final Map<String, WoundDeck> woundDecks;
  final bool Function(Event event) eventHandler;

  const DeckWidget(this.woundDecks, this.eventHandler, {super.key});

  @override
  build(BuildContext context) {
    final List<String> woundDeckIds = woundDecks.keys.toList();
    print(woundDecks);
    // final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: 1200,
      height: 176,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.indigo[700],
        child: Center(
          child: ListView.builder(
            padding: const EdgeInsets.only(right: 4, left: 4),
            itemCount: woundDeckIds.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              final wound = woundDecks[woundDeckIds[index]];
              if (wound != null) {
                return DeckItem(wound, eventHandler);
              } else {
                return Center(child: Text("Can't find deck with id: ${woundDeckIds[index]}"));
              }
            },
          ),
        ),
      ),
    );
  }
}

class DeckItem extends StatelessWidget {
  final WoundDeck woundDeck;
  final bool Function(Event event) eventHandler;
  const DeckItem(this.woundDeck, this.eventHandler, {super.key});

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: SizedBox(
        height: 160,
        width: 120,
        child: Card(
          color: Colors.white54,
          child: Center(child: Text(woundDeck.id)),
        ),
      ),
    );
  }
}
