import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:least_sum/db/firebase_database.dart';
import 'package:least_sum/res/strings.dart';
import 'package:least_sum/screens/home.dart';

class JoinGame extends StatelessWidget {
  final gameCodeContainer = GameCodeContainer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Join Game')),
        body: Column(
          children: [
            TextField(
              onChanged: gameCodeContainer.updateGameCode,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: enterGameCode),
            ),
            MaterialButton(
              onPressed: () async {
                final gameCode = gameCodeContainer.gameCode;
                bool joined = await joinGame(gameCode);
                if (joined) {
                  openGame(gameCode, context);
                }
              },
              child: Text('Join'),
            )
          ],
        ));
  }
}

class GameCodeContainer {
  String gameCode;

  void updateGameCode(String text) {
    gameCode = text.trim().toLowerCase();
  }
}
