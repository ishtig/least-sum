import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:least_sum/db/firebase_database.dart';
import 'package:least_sum/game/game.dart';
import 'package:least_sum/res/strings.dart' as Strings;

import 'game_screen.dart';

class CreatorUserListPage extends StatelessWidget {
  final String gameCode;
  final List<String> players = <String>[];

  CreatorUserListPage(this.gameCode);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Joined Users')),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StreamBuilder<Event>(
                stream: getGamePlayers(gameCode),
                builder: (context, eventSnapshot) {
                  if (!eventSnapshot.hasData) {
                    return Center(child: Text('Loading...'));
                  } else {
                    var event = eventSnapshot.data;
                    if (event.snapshot.value is Map) {
                      var playersMap = event.snapshot.value as Map;
                      players.clear();
                      playersMap.forEach((key, value) {
                        players.add(key);
                      });
                    }
                    if (players.length < 2) {
                      return Text(
                          'Waiting for players to join. Share your game code: $gameCode');
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Center(child: Text(players[index]));
                        },
                        itemCount: players.length);
                  }
                }),
            ElevatedButton(
                onPressed: () async {
                  if (players.length >= 2) {
                    await startGame(players);
                    openGame(gameCode, context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("Waiting for players to join."),
                    ));
                  }
                },
                child: Text(Strings.startGame))
          ],
        )));
  }

  startGame(List<String> players) async {
    Game game = createNewGame(players);

    await sendGame(game, gameCode);
  }
}
