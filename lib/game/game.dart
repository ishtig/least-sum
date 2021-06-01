import 'dart:math';

import 'package:least_sum/components/cards.dart';
import 'package:least_sum/components/dealer.dart';
import 'package:least_sum/components/shuffle.dart';
import 'package:stack/stack.dart';

enum GameStatus { notStarted, waitingToStart, started, finished, exited }

class Game {
  GameStatus status;
  List<String> players;
  Stack<Card> centreStack;
  Stack<Card> cardsStack;
  Map<String, List<Card>> playerCards;
  String nextPlayer;

  Game(this.status, this.players, this.centreStack, this.cardsStack,
      this.playerCards, this.nextPlayer);

  List<int> playerCardsAsNum(String player) {
    var currentPlayerCards = playerCards[player];
    var cardsAsNumbers = <int>[];
    for (int i = 0; i < currentPlayerCards.length; i++) {
      cardsAsNumbers.add(getNumberForCard(currentPlayerCards[i]));
    }
    return cardsAsNumbers;
  }

  List<int> cardsStackAsList() {
    List<int> cardsStackList = <int>[];
    while (cardsStack.isNotEmpty) {
      cardsStackList.add(getNumberForCard(cardsStack.pop()));
    }
    return cardsStackList;
  }

  List<int> centreStackAsList() {
    List<int> centreStackList = <int>[];
    while (centreStack.isNotEmpty) {
      centreStackList.add(getNumberForCard(centreStack.pop()));
    }
    return centreStackList;
  }
}

Game gameFromMap(Map<dynamic, dynamic> gameMap) {
  var status = GameStatus.values[gameMap['gameState']];
  var players = <String>[];
  Map<dynamic, dynamic> playersMap = gameMap['players'];
  playersMap.forEach((key, value) {
    players.add(key);
  });
  Stack<Card> centreStack = _centreStackFromMap(gameMap);

  Stack<Card> cardsStack = _cardsStackFromMap(gameMap);
  Map<dynamic, dynamic> playersCardsNumbered = gameMap['playerCards'];
  Map<String, List<Card>> playersCards = Map<String, List<Card>>();
  playersCardsNumbered.forEach((key, value) {
    playersCards.putIfAbsent(key, () => getCardsForNumbers(value));
  });

  String nextPlayer = gameMap['nextPlayer'];

  return Game(
      status, players, centreStack, cardsStack, playersCards, nextPlayer);
}

Stack<Card> _cardsStackFromMap(Map<dynamic, dynamic> gameMap) {
  Stack<Card> cardsStack = Stack();
  List<dynamic> cardsStackList = gameMap['cardsStack'];
  for (var cardNumber in cardsStackList) {
    cardsStack.push(getCardForNumber(cardNumber));
  }
  return cardsStack;
}

Stack<Card> _centreStackFromMap(Map<dynamic, dynamic> gameMap) {
  Stack<Card> centreStack = Stack();
  List<dynamic> centreStackList = gameMap['centreStack'];
  if (centreStackList == null) {
    return Stack();
  }
  for (var cardNumber in centreStackList) {
    centreStack.push(getCardForNumber(cardNumber));
  }
  return centreStack;
}

Game createNewGame(List<String> players) {
  var shuffledCards = shuffleCards(jokersCount: 2);
  var cardsForPlayers = deal(shuffledCards, numOfPlayers: players.length);
  var cardsWithPlayerNames = Map<String, List<Card>>();
  for (int i = 0; i < players.length; i++) {
    cardsWithPlayerNames.putIfAbsent(players[i], () => cardsForPlayers[i]);
  }
  return Game(GameStatus.started, players, Stack(), shuffledCards,
      cardsWithPlayerNames, players[Random().nextInt(players.length)]);
}
