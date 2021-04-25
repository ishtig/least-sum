import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';
import 'package:least_sum/components/cards.dart';

void main() {
  group('getNumberForCard', () {
    test('heart', () {
      var number = getNumberForCard(Card(Suit.heart, 0));
      expect(number, 13);
    });
    test('diamond', () {
      var number = getNumberForCard(Card(Suit.diamond, 12));
      expect(number, 51);
    });
    test('spade', () {
      var number = getNumberForCard(Card(Suit.spade, 1));
      expect(number, 1);
    });
    test('club', () {
      var number = getNumberForCard(Card(Suit.club, 6));
      expect(number, 32);
    });
    test('joker', () {
      var number = getNumberForCard(Card(Suit.joker, 2));
      expect(number, 54);
    });
  });
  group('getCardForNumber', () {
    test('spade', () {
      var card = getCardForNumber(12);
      expect(card.number, 12);
      expect(card.suit, Suit.spade);
    });
    test('heart', () {
      var card = getCardForNumber(13);
      expect(card.number, 0);
      expect(card.suit, Suit.heart);
    });
    test('club', () {
      var card = getCardForNumber(29);
      expect(card.number, 3);
      expect(card.suit, Suit.club);
    });
    test('diamond', () {
      var card = getCardForNumber(39);
      expect(card.number, 0);
      expect(card.suit, Suit.diamond);
    });
  });
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
      var cards = shuffleCards();
      // Create a copy since shuffle does an in place shuffling of cards
      var shuffledCards = List.of(cards);
      shuffle(shuffledCards);

      testCardsNotInSameOrder(shuffledCards, cards);
      testAllCardsShuffledWithoutRepetition(shuffledCards);
    });

    test('shuffleCards works properly with jokers', () {
      var cards = shuffleCards(jokersCount: 4);
      // Create a copy since shuffle does an in place shuffling of cards
      var shuffledCards = List.of(cards);
      shuffle(shuffledCards);

      testCardsNotInSameOrder(shuffledCards, cards);
      testAllCardsShuffledWithoutRepetition(shuffledCards);
    });
  });
}

void testAllCardsShuffledWithoutRepetition(List<Card> shuffledCards) {
  Set<int> cardsEncountered = HashSet();
  for (int i = 0; i < shuffledCards.length; i++) {
    var numberForCard = getNumberForCard(shuffledCards[i]);
    cardsEncountered.add(numberForCard);
  }
  expect(cardsEncountered.length, shuffledCards.length);
}

void testCardsNotInOrder(List<Card> shuffledCards) {
  var areCardsInOrder = true;

  for (int i = 0; i < shuffledCards.length; i++) {
    var numberForCard = getNumberForCard(shuffledCards[i]);
    if (numberForCard != i) {
      areCardsInOrder = false;
      break;
    }
  }
  expect(areCardsInOrder, false);
}

void testCardsNotInSameOrder(
    List<Card> shuffledCards, List<Card> preShuffledCards) {
  var areCardsInOrder = true;

  for (int i = 0; i < shuffledCards.length; i++) {
    if (getNumberForCard(shuffledCards[i]) !=
        getNumberForCard(preShuffledCards[i])) {
      areCardsInOrder = false;
      break;
    }
  }
  expect(areCardsInOrder, false);
}
