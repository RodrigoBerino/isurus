import '../models/card.dart';

class CardService {
  final List<CardModel> _cards = [];

  void addCard(CardModel card) {
    _cards.add(card);
  }

  void activateCard(String cardNumber) {
    _cards.firstWhere((c) => c.cardNumber == cardNumber).activate();
  }

  void blockCard(String cardNumber) {
    _cards.firstWhere((c) => c.cardNumber == cardNumber).block();
  }

  List<CardModel> getAll() => _cards;
}
