import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:least_sum/components/cards.dart' as CardComponent;
import 'package:least_sum/db/firebase_database.dart';
import 'package:least_sum/game/game.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage(this.gameCode, {Key key}) : super(key: key);

  final String gameCode;

  @override
  _MyHomePageState createState() => _MyHomePageState(gameCode);
}

class _MyHomePageState extends State<MyHomePage> {
  final String gameCode;

  _MyHomePageState(this.gameCode);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Least Sum'),
      ),
      body: buildGameGround(),
    );
  }

  Widget buildGameGround() {
    return new FutureBuilder<Game>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Game game = snapshot.data;
            return ListView.builder(
                itemCount: game.players.length,
                itemBuilder: (context, index) {
                  String player = game.players[index];
                  return Text('$player: ' +
                      getStringForCardsWith(game.playerCards[player], true));
                });
          }
          return Center(
            child: Text('error loading game ' + snapshot.error.toString()),
          );
        },
        future: getGame(gameCode));
  }

  String getStringForCardsWith(
      List<CardComponent.Card> playerCards, bool isHorizontal) {
    String string = '';
    for (CardComponent.Card card in playerCards) {
      string += (isHorizontal ? ' ' : '\n') + card.toString();
    }
    return string;
  }
}

void openGame(String gameCode, BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => MyHomePage(gameCode)));
}
