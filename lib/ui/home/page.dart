import 'package:flutter/material.dart';
import 'package:snd/event_processor/event.dart';
import 'package:snd/ui/base/page.dart';

class HomePage extends MyPage<String> {
  const HomePage({super.key, required super.stream, required super.initialData, required super.eventHandler});

  @override
  Widget build(BuildContext context, AsyncSnapshot<String> snap) {
    String data = snap.data ?? "NO DATA";

    return Column(
      children: [
        Center(child: Text(data)),
        SizedBox(
          height: 120,
          child: Card(
            color: Colors.green,
            child: Row(
              children: [
                TextButton(
                  child: Text("Character creation"),
                  onPressed: () {
                    eventHandler(Event("goto", params: {"route_id": "character_creation"}));
                  },
                ),
                TextButton(
                  child: Text("Battle"),
                  onPressed: () {
                    eventHandler(Event("goto", params: {"route_id": "battle"}));
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
