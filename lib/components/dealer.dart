import 'dart:collection';

import 'package:least_sum/components/cards.dart';
import 'package:stack/stack.dart';

Map<int, List<Card>> deal(Stack<Card> cards,
    {int numOfPlayers = 2, int numOfCards = 5}) {
  var playerCardsMap = HashMap<int, List<Card>>();
  for (int i = 0; i < numOfPlayers; i++) {
    playerCardsMap.putIfAbsent(i, () => List.empty(growable: true));
  }

  var cardsToBeDistributed = numOfCards * numOfPlayers;
  if (cardsToBeDistributed > cards.length) {
    throw ArgumentError(
        'Cannot distribute $numOfCards to $numOfPlayers: Not enough cards');
  }

  for (int i = 0; i < cardsToBeDistributed; i++) {
    playerCardsMap[i % numOfPlayers].add(cards.pop());
  }
  return playerCardsMap;
}
