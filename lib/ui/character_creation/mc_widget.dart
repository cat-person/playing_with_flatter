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
    final statKeys = mc.stats.keys.toList();
    return SizedBox(
      height: 320,
      width: 1200,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.green[900],
        child: Center(
          child: Column(
            children: [
              Text("Hero: ${mc.originId}", style: textTheme.titleLarge?.copyWith(color: Colors.red[200])),
              Text(mc.sigils.join(', '), style: textTheme.titleSmall?.copyWith(color: Colors.deepOrange[200])),
              SizedBox(
                height: 160,
                width: 280,
                child: ListView.builder(
                  padding: const EdgeInsets.all(4),
                  itemCount: mc.stats.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String statId = statKeys[index];
                    final int? statValue = mc.stats[statId];
                    if (statId.isNotEmpty && statValue != null) {
                      return Text("$statId: $statValue", style: textTheme.titleSmall?.copyWith(color: Colors.grey[200]));
                    }
                    return Text("Can't read stat with index: $index");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
