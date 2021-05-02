import 'dart:math';

import 'package:least_sum/components/cards.dart';
import 'package:stack/stack.dart';

var _random = Random(52);

/// Returns a [Stack] of shuffled deck of cards.
///
/// [jokerCount] denotes the number of jokers to add in the deck.
Stack<Card> shuffleCards({int jokersCount = 0}) {
  var cards = List.generate(
      cardsInADeck + jokersCount, (i) => getCardForNumber(i),
      growable: false);
  return shuffle(cards);
}

/// Returns a [Stack] of shuffled [cards].
Stack<Card> shuffle(List<Card> cards) {
  var shuffledCardsStack = Stack<Card>();
  for (var i = 0; i < cards.length; i++) {
    var swapPosition = i + _random.nextInt(cards.length - i);
    var temp = cards[i];
    cards[i] = cards[swapPosition];
    cards[swapPosition] = temp;
    shuffledCardsStack.push(cards[i]);
  }
  return shuffledCardsStack;
}
