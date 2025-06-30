import 'package:bank_app/models/card_type.dart';
import 'package:bank_app/models/card_status.dart';

class Card {
  final String cardNumber;
  final String expirationDate;
  final String cvv;
  final CardType cardType;
  CardStatus status;
  final String customerId; // Link to customer
  final String accountNumber; // Link to account

  Card({
    required this.cardNumber,
    required this.expirationDate,
    required this.cvv,
    required this.cardType,
    this.status = CardStatus.active,
    required this.customerId,
    required this.accountNumber,
  });

  void activate() {
    status = CardStatus.active;
  }

  void block() {
    status = CardStatus.blocked;
  }

  Map<String, dynamic> toMap() {
    return {
      'cardNumber': cardNumber,
      'expirationDate': expirationDate,
      'cvv': cvv,
      'cardType': cardType.toString().split('.').last,
      'status': status.toString().split('.').last,
      'customerId': customerId,
      'accountNumber': accountNumber,
    };
  }

  factory Card.fromMap(Map<String, dynamic> map) {
    return Card(
      cardNumber: map['cardNumber'],
      expirationDate: map['expirationDate'],
      cvv: map['cvv'],
      cardType: CardType.values.firstWhere(
          (e) => e.toString().split('.').last == map['cardType']),
      status: CardStatus.values.firstWhere(
          (e) => e.toString().split('.').last == map['status']),
      customerId: map['customerId'],
      accountNumber: map['accountNumber'],
    );
  }
}