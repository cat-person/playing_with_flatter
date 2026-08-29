import 'package:flutter/material.dart';
import 'package:snd/repo/mc_repo.dart';
import 'package:snd/repo/origins_repo.dart';
import 'package:snd/repo/sigils_repo.dart';
import 'package:snd/ui/console/my_console.dart';
import 'vm/main/main_vm.dart';
import 'package:snd/ui/home_page.dart';
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

    MainVM mainVM = MainVM(mcRepo, originsRepo, sigilsRepo, proxy: consoleProxy);
    return MaterialApp(
      home: Column(
        children: [
          HomePage(stream: mainVM.stream, initialData: mainVM.latestState, eventHandler: mainVM.eventHandler),
          Spacer(),
          MyConsoleWidget(consoleVM.stream, [], consoleVM.eventHandler),
        ],
      ),
    );
  }
}
