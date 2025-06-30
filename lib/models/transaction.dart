import '../core/enums/transaction_type.dart';
import 'package:flutter/widgets.dart';

class Transaction {
  final String transactionId;
  final DateTime date;
  final double quantity;
  final TransactionType type;
  final String description;

  Transaction({
    required this.transactionId,
    required this.date,
    required this.quantity,
    required this.type,
    required this.description,
  });

  factory Transaction.deposit(double amount, String description) =>
      Transaction(
        transactionId: UniqueKey().toString(),
        date: DateTime.now(),
        quantity: amount,
        type: TransactionType.DEPOSIT,
        description: description,
      );

  factory Transaction.transfer(double amount, String description) =>
      Transaction(
        transactionId: UniqueKey().toString(),
        date: DateTime.now(),
        quantity: amount,
        type: TransactionType.TRANSFER,
        description: description,
      );
}
