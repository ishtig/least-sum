import 'package:flutter_test/flutter_test.dart';
import 'package:least_sum/components/cards.dart';
import 'package:least_sum/components/dealer.dart';
import 'package:stack/stack.dart';

void main() {
  group('deal cards', () {
    test('test default state', () {
      Stack<Card> cards = Stack.sized(10);
      List<Card> cardsCopy = List.generate(10, getCardForNumber);
      for (int i = cardsCopy.length - 1; i >= 0; i--) {
        cards.push(cardsCopy[i]);
      }

      var playerCards = deal(cards);

      expect(playerCards.length, 2);
      expect(playerCards[0].length, 5);
      expect(playerCards[1].length, 5);

      expect(playerCards[0][0].faceNumber, 0);
      expect(playerCards[0][1].faceNumber, 2);
      expect(playerCards[0][2].faceNumber, 4);
      expect(playerCards[0][3].faceNumber, 6);
      expect(playerCards[0][4].faceNumber, 8);

      expect(playerCards[1][0].faceNumber, 1);
      expect(playerCards[1][1].faceNumber, 3);
      expect(playerCards[1][2].faceNumber, 5);
      expect(playerCards[1][3].faceNumber, 7);
      expect(playerCards[1][4].faceNumber, 9);
    });
    test('test 3 players 4 cards', () {
      var playersCount = 3;
      var cardsToBeDealt = 4;
      Stack<Card> cards = Stack.sized(12);
      List<Card> cardsCopy = List.generate(12, getCardForNumber);
      for (int i = cardsCopy.length - 1; i >= 0; i--) {
        cards.push(cardsCopy[i]);
      }

      var playerCards =
          deal(cards, numOfCards: cardsToBeDealt, numOfPlayers: playersCount);

      expect(playerCards.length, 3);
      expect(playerCards[0].length, 4);
      expect(playerCards[1].length, 4);
      expect(playerCards[2].length, 4);

      expect(playerCards[0][0].faceNumber, 0);
      expect(playerCards[1][0].faceNumber, 1);
      expect(playerCards[2][0].faceNumber, 2);
      expect(playerCards[0][1].faceNumber, 3);
      expect(playerCards[1][1].faceNumber, 4);
      expect(playerCards[2][1].faceNumber, 5);
      expect(playerCards[0][2].faceNumber, 6);
      expect(playerCards[1][2].faceNumber, 7);
      expect(playerCards[2][2].faceNumber, 8);
      expect(playerCards[0][3].faceNumber, 9);
      expect(playerCards[1][3].faceNumber, 10);
      expect(playerCards[2][3].faceNumber, 11);
    });
    test('no cards to deal', () {
      var cards = Stack<Card>();
      expect(() => deal(cards), throwsA(isA<ArgumentError>()));
    });
    test('not enough cards to deal', () {
      var cards = Stack<Card>();
      cards.push(getCardForNumber(30));
      cards.push(getCardForNumber(6));
      cards.push(getCardForNumber(42));
      expect(() => deal(cards), throwsA(isA<ArgumentError>()));
    });
  });
}
