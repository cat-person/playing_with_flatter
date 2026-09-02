import 'package:flutter/material.dart';
import 'package:snd/event_processor/event.dart';
import 'package:snd/repo/mc_repo.dart';
import 'package:snd/repo/origins_repo.dart';
import 'package:snd/repo/sigils_repo.dart';
import 'package:snd/repo/wound_deck_repo.dart';
import 'package:snd/ui/battle/page.dart';
import 'package:snd/ui/console/my_console.dart';
import 'vm/battle_vm.dart';
import 'vm/character_creation_vm.dart';
import 'vm/home_vm.dart';
import 'package:snd/repo/pojo/wound.dart';
import 'vm/navigation_vm.dart';
import 'package:snd/ui/home/page.dart';
import 'package:snd/ui/character_creation/page.dart';
import 'package:snd/repo/console_repo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    ConsoleProxy consoleProxy = ConsoleProxy();
    ConsoleVM consoleVM = ConsoleVM(consoleProxy);

    MCRepo mcRepo = MCRepo(proxies: [consoleProxy]);
    OriginsRepo originsRepo = OriginsRepo(proxies: [consoleProxy]);
    SigilsRepo sigilsRepo = SigilsRepo(proxies: [consoleProxy]);
    WoundDeckRepo woundDeckRepo = WoundDeckRepo(
      WoundDeckState({"wound_light": LightDeck(), "wound_serious": SeriousDeck(), "wound_severe": SevereDeck()}, {}, []),
      proxies: [consoleProxy],
    );

    NavigationVM navigationVM = NavigationVM(NavState("home", {}), proxies: [consoleVM]);

    BattleVM battleVM = BattleVM(mcRepo, woundDeckRepo, originsRepo, sigilsRepo, proxies: [navigationVM, consoleProxy]);
    CharacterCreationVM characterCreationVM = CharacterCreationVM(mcRepo, originsRepo, sigilsRepo, proxies: [navigationVM, consoleProxy]);
    HomeVM homeVM = HomeVM(proxies: [consoleProxy, navigationVM]);

    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      home: Column(
        children: [
          SizedBox(
            height: 640,
            child: StreamBuilder<NavState>(
              stream: navigationVM.stream,
              builder: (BuildContext context, AsyncSnapshot<NavState> snapshot) {
                NavState? state = snapshot.data;
                consoleProxy.eventHandler(Event("Nav changed", params: {"data": state}));
                return switch (state?.id) {
                  "home" => HomePage(stream: homeVM.stream, initialData: "Pupupu", eventHandler: homeVM.eventHandler),
                  "character_creation" => CharacterCreationPage(
                    stream: characterCreationVM.stream,
                    initialData: characterCreationVM.latestState,
                    eventHandler: characterCreationVM.eventHandler,
                  ),
                  "battle" => BattlePage(stream: battleVM.stream, initialData: battleVM.latestState, eventHandler: battleVM.eventHandler),
                  _ => HomePage(stream: homeVM.stream, initialData: "Default", eventHandler: homeVM.eventHandler),
                };
              },
            ),
          ),
          Spacer(),
          SizedBox(
            height: 52,
            child: Card(
              color: Colors.blueGrey,
              child: Row(
                children: [
                  TextButton(
                    child: Text("Character creation", style: textTheme.titleLarge?.copyWith(color: Colors.white70)),
                    onPressed: () {
                      navigationVM.eventHandler(Event("goto", params: {"route_id": "character_creation"}));
                    },
                  ),
                  TextButton(
                    child: Text("Battle", style: textTheme.titleLarge?.copyWith(color: Colors.white70)),
                    onPressed: () {
                      navigationVM.eventHandler(Event("goto", params: {"route_id": "battle"}));
                    },
                  ),

                  TextButton(
                    child: Text("Home", style: textTheme.titleLarge?.copyWith(color: Colors.white70)),
                    onPressed: () {
                      navigationVM.eventHandler(Event("goto", params: {"route_id": "home"}));
                    },
                  ),
                ],
              ),
            ),
          ),
          MyConsoleWidget(consoleVM.stream, [], consoleVM.eventHandler),
        ],
      ),
    );
  }
}
