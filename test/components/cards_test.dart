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
  group('getCardFace', () {
    test('invalid values throw error', () {
      expect(() => getCardFace(-1), throwsA(isA<ArgumentError>()));
      expect(() => getCardFace(13), throwsA(isA<ArgumentError>()));
    });
    test('works for numbered cards', () {
      expect(getCardFace(2), '3');
    });
    test('works for cards with faces', () {
      expect(getCardFace(0), 'A');
      expect(getCardFace(10), 'J');
      expect(getCardFace(11), 'Q');
      expect(getCardFace(12), 'K');
    });
  });
}
