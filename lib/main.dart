import 'package:flutter/material.dart';
import 'vm/main/main_vm.dart';
import 'vm/main/state.dart';
import 'package:snd/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MainVM mainVM = MainVM();
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: HomePage(
        stream: mainVM.stream,
        initialData: MainState("N"),
        eventHandler: mainVM.eventHandler,
      ),
    );
  }
}
