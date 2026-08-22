import 'package:flutter/material.dart';
import 'my_page.dart';
import '../vm/main/state.dart';
import '../vm/main/event.dart';

class HomePage extends MyPage<MainState, MainEvent> {
  const HomePage({
    super.key,
    required super.stream,
    required super.initialData,
    required super.eventHandler,
  });

  @override
  Widget build(BuildContext context, AsyncSnapshot<MainState> snap) {
    final ThemeData theme = Theme.of(context);

    final ColorScheme colorScheme = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Spacer(),
          Wrap(
            direction: Axis.horizontal,
            spacing: 8.0, // gap between adjacent children
            runSpacing: 4.0, // gap between lines
            children: [
              Text("${snap.data?.letter}"),
              Text("UwU: ${snap.data?.letter}"),
              Text("${snap.data?.letter}"),
            ],
          ),
          Spacer(),
          Wrap(
            direction: Axis.horizontal,
            spacing: 8.0, // gap between adjacent children
            runSpacing: 4.0, // gap between lines
            children: [
              TextButton(
                onPressed: () {
                  eventHandler(A());
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: const .all(Radius.circular(8)),
                    side: BorderSide(color: colorScheme.primary, width: 5),
                  ),
                ),
                child: Text("A"),
              ),
              TextButton(
                onPressed: () {
                  eventHandler(B());
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: const .all(Radius.circular(8)),
                    side: BorderSide(color: colorScheme.primary, width: 5),
                  ),
                ),
                child: Text("B"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
