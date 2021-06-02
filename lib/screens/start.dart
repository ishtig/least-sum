import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:least_sum/db/firebase_database.dart';
import 'package:least_sum/res/strings.dart' as Strings;
import 'package:least_sum/screens/creator_wait.dart';

import 'join_game.dart';

class StartGame extends StatelessWidget {
  final UserIdTextChangeListener _userIdTextChangeListener =
      UserIdTextChangeListener();

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
            Padding(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
              child: TextField(
                onChanged: _userIdTextChangeListener.onTextChanged,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(), hintText: 'Enter username'),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (isUserIdValid()) {
                    showJoinGame(context);
                  } else {
                    showInvalidUserIdSnackbar(context);
                  }
                },
                child: Text(Strings.letsPlay)),
            TextButton(
                onPressed: () async {
                  if (isUserIdValid()) {
                    String gameCode = _userIdTextChangeListener.userId;
                    await createGame(gameCode);
                    showGameCreated(context, gameCode);
                  } else {
                    showInvalidUserIdSnackbar(context);
                  }
                },
                child: Text(Strings.createGame))
          ],
        )));
  }

  void showInvalidUserIdSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content:
          Text("Enter valid user id. It should be of at least 5 characters."),
    ));
  }

  bool isUserIdValid() {
    // TODO(ishti): check for user id uniqueness
    return _userIdTextChangeListener.userId.length > 4;
  }
}

class UserIdTextChangeListener {
  String userId = '';

  void onTextChanged(String value) {
    while (value.contains('  ')) {
      value.replaceAll('  ', ' ');
    }
    value.replaceAll('\n', ' ');
    userId = value.trim();
  }
}

showGameCreated(BuildContext context, String gameCode) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => CreatorUserListPage(gameCode)));
}

showJoinGame(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => JoinGame()));
}
