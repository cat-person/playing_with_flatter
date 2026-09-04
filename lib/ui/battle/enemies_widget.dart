import 'package:flutter/material.dart';
import 'package:snd/repo/pojo/creature.dart';
import 'package:snd/event_processor/event.dart';

class EnemiesWidget extends StatelessWidget {
  final Map<String, Creature> enemies;
  final bool Function(Event event) eventHandler;

  const EnemiesWidget(this.enemies, this.eventHandler, {super.key});

  @override
  build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final enemyKeys = enemies.keys.toList();
    return SizedBox(
      height: 176,
      width: 1200,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.limeAccent[900],
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(4),
          itemCount: enemyKeys.length,
          itemBuilder: (BuildContext context, int index) {
            final String statId = enemyKeys[index];
            final Creature? creature = enemies[statId];
            if (statId.isNotEmpty && creature != null) {
              return UnconstrainedBox(
                child: SizedBox(
                  height: 160,
                  width: 120,
                  child: Card(
                    color: Colors.purple,
                    child: Center(
                      child: Text(creature.name, style: textTheme.titleSmall?.copyWith(color: Colors.grey[200])),
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
