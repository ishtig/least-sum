import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:least_sum/db/firebase_database.dart';
import 'package:least_sum/res/strings.dart';
import 'package:least_sum/screens/player_wait.dart';

class JoinGame extends StatelessWidget {
  final gameCodeContainer = GameCodeContainer();
  final String userName;

  JoinGame(this.userName);

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
                bool joined = await joinGame(gameCode, userName);
                if (joined) {
                  openWaitScreen(gameCode, context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("Could not join game. Check code.")));
                }
              },
              child: Text('Join'),
            )
          ],
        ));
  }
}

void openWaitScreen(String gameCode, BuildContext context) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => PlayerWaitScreen(gameCode)));
}

class GameCodeContainer {
  String gameCode;

  void updateGameCode(String text) {
    gameCode = text.trim().toLowerCase();
  }
}
