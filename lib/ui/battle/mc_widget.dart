import 'package:flutter/material.dart';
import 'package:snd/repo/pojo/mc.dart';
import 'package:snd/event_processor/event.dart';

class MCWidget extends StatelessWidget {
  final MC mc;
  final bool Function(Event event) eventHandler;

  const MCWidget(this.mc, this.eventHandler, {super.key});

  @override
  build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // final statKeys = mc.stats.keys.toList();
    return SizedBox(
      height: 220,
      width: 1200,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.green[900],
        child: Column(
          children: [
            Text("Hero: ${mc.originId}", style: textTheme.titleLarge?.copyWith(color: Colors.red[200])),
            Text(mc.sigils.join(', '), style: textTheme.titleSmall?.copyWith(color: Colors.deepOrange[200])),
            SizedBox(
              height: 32,
              width: 80,
              child: GestureDetector(
                onTap: () {
                  eventHandler(Event("perform", params: {"action_id": "throw_dice", "performed_by": "mc"}));
                },
                child: Card(
                  color: Colors.white,
                  child: Center(
                    child: Text("Throw dice", style: textTheme.labelMedium?.copyWith(color: Colors.indigo)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                scrollDirection: Axis.horizontal,
                itemCount: ["heal", "bite"].length,
                itemBuilder: (BuildContext context, int index) {
                  final String actionId = ["heal", "bite"][index];
                  return SizedBox(
                    height: 40,
                    width: 140,
                    child: GestureDetector(
                      onTap: () {
                        eventHandler(Event("perform", params: {"action_id": actionId}));
                      },
                      child: Card(
                        color: Colors.tealAccent,
                        child: Center(
                          child: Text(actionId, style: textTheme.labelLarge?.copyWith(color: Colors.blueAccent)),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
