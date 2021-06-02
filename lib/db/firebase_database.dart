import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:least_sum/game/game.dart';

DatabaseReference db;

Future<void> initDatabase() async {
  if (db == null) {
    await Firebase.initializeApp();
    db = FirebaseDatabase(app: Firebase.app()).reference();
  }
}

Future<void> createGame(String userName) async {
  await initDatabase();
  // TODO(ishti): validate that is game does not exist.
  db.child('games/$userName').child('players').child(userName).set('false');
}

Future<bool> joinGame(String gameCode) async {
  await initDatabase();
  var games = db.child('games');
  var value = await games.child(gameCode).once().then((value) => value);

  return value != null;
}

Stream<Event> getGamePlayers(String gameCode) {
  var game = db.child('games/$gameCode');
  return game.child('players').orderByKey().onValue;
}

sendGame(Game game, String gameCode) async {
  var currentGameState = db.child('games/$gameCode');
  var players = currentGameState.child('players');
  var playerCards = currentGameState.child('playerCards');
  for (int i = 0; i < game.players.length; i++) {
    var player = game.players[i];
    players.child(player).set(true);
    playerCards.child(player).set(game.playerCardsAsNum(player));
  }
  currentGameState.child('gameState').set(game.status.index);
  currentGameState.child('centreStack').set(game.centreStackAsList());
  currentGameState.child('cardsStack').set(game.cardsStackAsList());
  currentGameState.child('nextPlayer').set(game.nextPlayer);
}

Future<Game> getGame(String gameCode) async {
  var gameDbSnapshot = await db.child('games/$gameCode').once();
  var gameMap = gameDbSnapshot.value as Map<dynamic, dynamic>;
  return gameFromMap(gameMap);
}
