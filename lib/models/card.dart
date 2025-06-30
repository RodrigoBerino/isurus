import '../core/enums/card_type.dart';
import '../core/enums/card_status.dart';

class CardModel {
  final String cardNumber;
  final String expirationDate;
  final String cvv;
  final CardType cardType;
  CardStatus status;

  CardModel({
    required this.cardNumber,
    required this.expirationDate,
    required this.cvv,
    required this.cardType,
    required this.status,
  });

  void activate() => status = CardStatus.ACTIVE;
  void block() => status = CardStatus.BLOCKED;
}
