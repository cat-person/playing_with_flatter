import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/main/bloc.dart';
import '../bloc/main/event.dart';
import '../bloc/main/state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final ColorScheme colorScheme = theme.colorScheme;

    final MainBloc mainBloc = context.read<MainBloc>();
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
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
                  Text(state.letter),
                  Text("UwU: ${state.letter}"),
                  Text(state.letter),
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
                      mainBloc.add(A());
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
                      mainBloc.add(B());
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
      },
    );
  }
}
