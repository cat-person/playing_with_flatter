import 'package:flutter/material.dart';
import 'package:snd/repo/pojo/wound.dart';
import 'package:snd/event_processor/event.dart';

class WoundCardsWidget extends StatelessWidget {
  final List<String> wounds;
  final Map<String, Wound> woundCollection;
  final bool Function(Event event) eventHandler;

  const WoundCardsWidget(this.wounds, this.woundCollection, this.eventHandler, {super.key});

  @override
  build(BuildContext context) {
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
            itemCount: wounds.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              Wound? wound = woundCollection[wounds[index]];
              if (wound != null) {
                return CardItem(wound, eventHandler);
              }
            },
          ),
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final Wound wound;
  final bool Function(Event event) eventHandler;
  const CardItem(this.wound, this.eventHandler, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 60,
      child: Card(
        color: Colors.white54,
        child: Center(child: Text("${wound.priority}")),
      ),
    );
  }
}
