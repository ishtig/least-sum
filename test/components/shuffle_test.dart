import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';
import 'package:least_sum/components/cards.dart';
import 'package:least_sum/components/shuffle.dart';
import 'package:stack/stack.dart';

void main() {
  group('shuffleCards', () {
    test('shuffleCards works properly without jokers', () {
      var shuffledCards = shuffleCards();

      testCardsNotInOrder(shuffledCards);
      testAllCardsShuffledWithoutRepetition(shuffledCards);
    });

    test('shuffleCards works properly with jokers', () {
      var shuffledCards = shuffleCards(jokersCount: 4);

      testCardsNotInOrder(shuffledCards);
      testAllCardsShuffledWithoutRepetition(shuffledCards);
    });
  });

  group('shuffle existing list', () {
    test('shuffle works properly without jokers', () {
      var cards =
          List.generate(52, (i) => getCardForNumber(i), growable: false);
      // Create a copy since shuffle does an in place shuffling of cards
      var shuffledCards = shuffle(cards);

      testCardsNotInSameOrder(shuffledCards, cards);
      testAllCardsShuffledWithoutRepetition(shuffledCards);
    });

    test('shuffleCards works properly with jokers', () {
      var cards =
          List.generate(56, (i) => getCardForNumber(i), growable: false);
      // Create a copy since shuffle does an in place shuffling of cards
      var shuffledCards = shuffle(cards);

      testCardsNotInSameOrder(shuffledCards, cards);
      testAllCardsShuffledWithoutRepetition(shuffledCards);
    });
  });
}

void testAllCardsShuffledWithoutRepetition(Stack<Card> shuffledCards) {
  Stack<Card> reverseShuffledCards = Stack.sized(shuffledCards.length);
  Set<int> cardsEncountered = HashSet();
  while (shuffledCards.isNotEmpty) {
    var card = shuffledCards.pop();
    reverseShuffledCards.push(card);
    var numberForCard = getNumberForCard(card);
    cardsEncountered.add(numberForCard);
  }
  while (reverseShuffledCards.isNotEmpty) {
    shuffledCards.push(reverseShuffledCards.pop());
  }
  expect(cardsEncountered.length, shuffledCards.length);
}

void testCardsNotInOrder(Stack<Card> shuffledCards) {
  Stack<Card> reverseShuffledCards = Stack.sized(shuffledCards.length);
  var areCardsInOrder = true;
  int orderNumber = 0;
  int reverseOrderNumber = shuffledCards.length - 1;

  while (shuffledCards.isNotEmpty) {
    var card = shuffledCards.pop();
    reverseShuffledCards.push(card);
    var numberForCard = getNumberForCard(card);
    if (numberForCard != orderNumber && numberForCard != reverseOrderNumber) {
      areCardsInOrder = false;
      break;
    }
  }
  while (reverseShuffledCards.isNotEmpty) {
    shuffledCards.push(reverseShuffledCards.pop());
  }
  expect(areCardsInOrder, false);
}

void testCardsNotInSameOrder(
    Stack<Card> shuffledCards, Iterable<Card> preShuffledCards) {
  Stack<Card> reverseShuffledCards = Stack.sized(shuffledCards.length);
  var areCardsInOrder = true;

  for (int i = 0; i < shuffledCards.length; i++) {
    var card = shuffledCards.pop();
    reverseShuffledCards.push(card);
    if (getNumberForCard(card) !=
        getNumberForCard(preShuffledCards.elementAt(i))) {
      areCardsInOrder = false;
      break;
    }
  }
  while (reverseShuffledCards.isNotEmpty) {
    shuffledCards.push(reverseShuffledCards.pop());
  }
  expect(areCardsInOrder, false);
}
