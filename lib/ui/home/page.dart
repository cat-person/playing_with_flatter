import 'package:flutter/material.dart';
import 'package:snd/ui/base/page.dart';

class HomePage extends MyPage<String> {
  const HomePage({super.key, required super.stream, required super.initialData, required super.eventHandler});

  @override
  Widget build(BuildContext context, AsyncSnapshot<String> snap) {
    String data = snap.data ?? "NO DATA";

    return Center(child: Text(data));
  }
}
