enum Suit { spade, heart, club, diamond, joker }

const cardsInADeck = 52;

class Card {
  final Suit suit;
  final int faceNumber;

  Card(this.suit, this.faceNumber);

  @override
  String toString() {
    var icon = iconForSuit(suit);
    String cardNum = getCardFace(faceNumber);
    return "$icon$cardNum";
  }
}

/// Returns text unicode icons for suits.
String iconForSuit(Suit suit) {
  switch (suit) {
    case Suit.spade:
      return '♠';
    case Suit.heart:
      return '♥';
    case Suit.club:
      return '♣';
    case Suit.diamond:
      return '♦';
    case Suit.joker:
      return 'J';
  }
  throw ArgumentError('Unknown argument');
}

/// Returns the number or character displayed on the face corresponding to the
/// number.
///
/// 0 - 9 implies just numbers.
/// 10 = Jack
/// 11 = Queen
/// 12 = King
String getCardFace(int number) {
  switch (number) {
    case 0:
      return 'A';
    case 10:
      return 'J';
    case 11:
      return 'Q';
    case 12:
      return 'K';
  }
  if (number > 0 && number < 10) {
    return (number + 1).toString();
  }
  throw ArgumentError('Unknown card number: $number');
}

int getNumberForCard(Card card) {
  return card.suit.index * 13 + card.faceNumber;
}

Card getCardForNumber(num number) {
  var suitIndex = number / 13;
  return Card(Suit.values[suitIndex.toInt()], number - 13 * suitIndex.toInt());
}

List<int> getNumbersForCards(List<Card> cards) {
  var numbers = <int>[];
  for (var card in cards) {
    numbers.add(getNumberForCard(card));
  }
  return numbers;
}

List<Card> getCardsForNumbers(List<dynamic> numbers) {
  var cards = <Card>[];
  for (var number in numbers) {
    cards.add(getCardForNumber(number));
  }
  return cards;
}
