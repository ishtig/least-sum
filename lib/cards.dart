import 'dart:math';

enum Suit { spade, heart, club, diamond, joker }

class Card {
  final Suit suit;
  final int number;

  Card(this.suit, this.number);

  @override
  String toString() {
    return "$suit : $number";
  }
}

const _cardsInADeck = 52;

List<Card> shuffleCards({int jokersCount = 0}) {
  var cards = List.generate(
      _cardsInADeck + jokersCount, (i) => getCardForNumber(i),
      growable: false);
  return shuffle(cards);
}

List<Card> shuffle(List<Card> cards) {
  for (var i = 0; i < cards.length; i++) {
    var swapPosition = i + _random.nextInt(cards.length - i);
    var temp = cards[i];
    cards[i] = cards[swapPosition];
    cards[swapPosition] = temp;
  }
  return cards;
}

int getNumberForCard(Card card) {
  return card.suit.index * 13 + card.number;
}

Card getCardForNumber(num number) {
  var suitIndex = number / 13;
  return Card(Suit.values[suitIndex.toInt()], number - 13 * suitIndex.toInt());
}

var _random = Random(52);
