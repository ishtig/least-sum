import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:least_sum/db/firebase_database.dart';
import 'package:least_sum/game/game.dart';
import 'package:least_sum/screens/creator_wait.dart';
import 'package:least_sum/screens/game_screen.dart';

class PlayerWaitScreen extends StatelessWidget {
  final String gameCode;

  PlayerWaitScreen(this.gameCode);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Waiting...')),
        body: Center(
            child: StreamBuilder<Game>(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case GameStatus.waitingToStart:
                case GameStatus.notStarted:
                  return listViewOfPlayers(snapshot.data.players);
                case GameStatus.exited:
                case GameStatus.finished:
                  return Text('Game ended or closed');
                case GameStatus.started:
                  openGame(gameCode, context);
                  return Text('Starting...');
              }
            } else {
              return Text('Something went wrong');
            }
            return Text('What\' happening');
          },
          stream: getGameStream(gameCode),
        )));
  }
}
