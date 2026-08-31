import 'package:flutter/material.dart';

import 'package:snd/repo/pojo/origins.dart';
import 'package:snd/repo/pojo/mc.dart';
import 'package:snd/repo/pojo/sigil.dart';

import 'package:snd/ui/base/page.dart';
import 'package:snd/vm/battle_vm.dart';
import 'mc_widget.dart';

class BattlePage extends MyPage<BattleState> {
  const BattlePage({super.key, required super.stream, required super.initialData, required super.eventHandler});

  @override
  Widget build(BuildContext context, AsyncSnapshot<BattleState> snap) {
    BattleState? data = snap.data;

    if (data == null) {
      return Text("NO DATA");
    }

    final MC mc = data.mc;
    final Map<String, Origin> originCollection = data.originColleciton;
    final Map<String, Sigil> sigilCollection = data.sigilCollection;

    return Column(
      children: [
        SizedBox(height: 12), // Add spacing
        MCWidget(mc, eventHandler),
        SizedBox(height: 12), // Add spacing
      ],
    );
  }
}
