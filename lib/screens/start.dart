import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:least_sum/db/firebase_database.dart';
import 'package:least_sum/res/strings.dart' as Strings;
import 'package:least_sum/screens/creator_wait.dart';

import 'join_game.dart';

class StartGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Least Sum'),
        ),
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => showJoinGame(context),
                child: Text(Strings.letsPlay)),
            TextButton(
                onPressed: () async {
                  String gameCode = 'ishti';
                  await createGame(gameCode);
                  showGameCreated(context, gameCode);
                },
                child: Text(Strings.createGame))
          ],
        )));
  }
}

showGameCreated(BuildContext context, String gameCode) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => CreatorUserListPage(gameCode)));
}

showJoinGame(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => JoinGame()));
}
