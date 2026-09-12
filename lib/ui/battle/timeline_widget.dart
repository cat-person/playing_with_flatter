import 'package:flutter/material.dart';
import 'package:snd/repo/pojo/mc.dart';
import 'package:snd/event_processor/event.dart';
import 'package:snd/vm/battle_vm.dart';
import 'dart:ui';

class TimelineWidget extends StatelessWidget {
  final List<TurnEvent> timeline;
  final bool Function(Event event) eventHandler;

  const TimelineWidget(this.timeline, this.eventHandler, {super.key});

  @override
  build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // final statKeys = mc.stats.keys.toList();
    return SizedBox(
      height: 100,
      width: 1200,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.blueGrey[100],
        clipBehavior: Clip.antiAlias,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(
            context,
          ).copyWith(dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse, PointerDeviceKind.trackpad}),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            itemCount: 18,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 80,
                child: Card(child: Center(child: Text("AAA"))),
              );
            },
          ),
        ),
      ),
    );
  }
}
