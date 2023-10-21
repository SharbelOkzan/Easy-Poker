import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_poker/src/core/domain/entities/enums/card_index.dart';
import 'package:easy_poker/src/core/domain/entities/enums/card_suit.dart';
import 'package:easy_poker/src/core/domain/entities/enums/game_phase.dart';
import 'package:easy_poker/src/core/domain/entities/enums/player_id.dart';
import 'package:easy_poker/src/core/domain/entities/game.dart';
import 'package:easy_poker/src/core/domain/entities/player.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:easy_poker/src/core/domain/entities/card.dart' as c;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
              onPressed: () => _toOfflineGamePage(context),
              child: Text("offline")),
          TextButton(
              onPressed: () => _toOnlineGamePage(context),
              child: Text("online")),
        ],
      ),
    );
  }

  void _toOfflineGamePage(BuildContext context) {
    Navigator.pushNamed(context, "offline");
  }

  void _toOnlineGamePage(BuildContext context) {
    Navigator.pushNamed(context, "online");
  }
}
