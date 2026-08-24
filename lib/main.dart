import 'package:flutter/material.dart';
import 'package:snd/repo/origins.dart';
import 'package:snd/repo/sigil.dart';
import 'vm/main/main_vm.dart';
import 'package:snd/ui/home_page.dart';
import 'package:snd/ui/console/console.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    OriginsRepo originsRepo = OriginsRepo();
    SigilsRepo sigilsRepo = SigilsRepo();
    MainVM mainVM = MainVM(originsRepo, sigilsRepo);
    return ConsoleWrapper(
      showConsole: true,
      maxLines: 200,
      child: MaterialApp(
        home: HomePage(
          stream: mainVM.stream,
          initialData: mainVM.latestState,
          eventHandler: mainVM.eventHandler,
        ),
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is  the root of your application.
//   @override
//   Widget build(BuildContext context) {

//     return MaterialApp(
//       title: 'Flutter Pupupu',
//       theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
//       home: HomePage(
//         stream: mainVM.stream,
//         initialData: mainVM.latestState,
//         eventHandler: mainVM.eventHandler,
//       ),
//     );
//   }
// }
