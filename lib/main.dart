import 'package:flutter/material.dart';
import 'package:snd/repo/mc_repo.dart';
import 'package:snd/repo/origins_repo.dart';
import 'package:snd/repo/sigils_repo.dart';
import 'package:snd/ui/battle/page.dart';
import 'package:snd/ui/console/my_console.dart';
import 'vm/battle_vm.dart';
import 'vm/character_creation_vm.dart';
import 'vm/home_vm.dart';
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

    MCRepo mcRepo = MCRepo();
    OriginsRepo originsRepo = OriginsRepo(proxy: consoleProxy);
    SigilsRepo sigilsRepo = SigilsRepo(proxy: consoleProxy);

    BattleVM battleVM = BattleVM(mcRepo, originsRepo, sigilsRepo, proxy: consoleProxy);
    CharacterCreationVM characterCreationVM = CharacterCreationVM(mcRepo, originsRepo, sigilsRepo, proxy: consoleProxy);
    HomeVM homeVM = HomeVM();

    return MaterialApp(
      home: Column(
        children: [
          Navigator(
            // ← This changes
            initialRoute: '/home',
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case '/home':
                  return MaterialPageRoute(
                    // Make home page into group of buttons
                    builder: (_) => Center(
                      child: Text("AUF"),
                    ), // HomePage(stream: HomeVM().stream, initialData: "Initial", eventHandler: homeVM.eventHandler),
                  );
                case '/character_cereation':
                  return MaterialPageRoute(
                    builder: (_) => CharacterCreationPage(
                      stream: characterCreationVM.stream,
                      initialData: characterCreationVM.latestState,
                      eventHandler: characterCreationVM.eventHandler,
                    ),
                  );
                case '/battle':
                  return MaterialPageRoute(
                    builder: (_) =>
                        BattlePage(stream: battleVM.stream, initialData: battleVM.latestState, eventHandler: battleVM.eventHandler),
                  );
                default:
                  return MaterialPageRoute(
                    builder: (_) => HomePage(stream: homeVM.stream, initialData: "Initial", eventHandler: homeVM.eventHandler),
                  );
              }
            },
          ),
          Spacer(),
          MyConsoleWidget(consoleVM.stream, [], consoleVM.eventHandler),
        ],
      ),
    );
  }
}
