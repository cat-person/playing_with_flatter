import 'package:flutter/material.dart';
import 'package:snd/repo/pojo/dice.dart';
import 'package:snd/event_processor/event.dart';

class DiceWidget extends StatelessWidget {
  final Map<String, Dice> dices;
  final bool Function(Event event) eventHandler;

  const DiceWidget(this.dices, this.eventHandler, {super.key});

  @override
  build(BuildContext context) {
    final diceKeys = dices.keys.toList();
    return SizedBox(
      height: 48,
      width: 1200,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.blueGrey,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(4),
          itemCount: diceKeys.length,
          itemBuilder: (BuildContext context, int index) {
            final String diceId = diceKeys[index];
            final Dice? dice = dices[diceId];
            if (diceId.isNotEmpty && dice != null) {
              DiceColor diceColor = diceColorByStatId[dice.statId] ?? DiceColor(Colors.red, Colors.black);
              return UnconstrainedBox(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: GestureDetector(
                    onTap: () {
                      eventHandler(Event("perform", params: {"action_id": "throw_dice", "performed_by": dice.statId}));
                    },
                    child: Card(
                      color: diceColor.diceColor,
                      child: Center(
                        child: Center(
                          child: Text("${dice.roll}", style: TextStyle(color: diceColor.dotColor)),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
            return Text("Can't read stat with index: $index");
          },
        ),
      ),
    );
  }
}

Map<String, DiceColor> diceColorByStatId = {
  "mst": DiceColor(Colors.white, Colors.purple),
  "str": DiceColor(Colors.white, Colors.red),
  "spd": DiceColor(Colors.white, Colors.yellow),
  "pcp": DiceColor(Colors.white, Colors.green),
  "con": DiceColor(Colors.white, Colors.orange),
  "int": DiceColor(Colors.white, Colors.blue),
};

class DiceColor {
  final Color dotColor;
  final Color diceColor;

  DiceColor(this.dotColor, this.diceColor);
}
