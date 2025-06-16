import 'package:bank_app/models/transaction_type.dart';
import 'package:uuid/uuid.dart';

class Transaction {
  final String transactionId;
  final DateTime date;
  final double amount;
  final TransactionType type;
  final String description;
  final String accountNumber; // Added to link transaction to an account

  Transaction({
    String? transactionId,
    required this.date,
    required this.amount,
    required this.type,
    required this.description,
    required this.accountNumber,
  }) : transactionId = transactionId ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'transactionId': transactionId,
      'date': date.toIso8601String(),
      'amount': amount,
      'type': type.toString().split('.').last,
      'description': description,
      'accountNumber': accountNumber,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      transactionId: map['transactionId'],
      date: DateTime.parse(map['date']),
      amount: map['amount'],
      type: TransactionType.values.firstWhere(
          (e) => e.toString().split('.').last == map['type']),
      description: map['description'],
      accountNumber: map['accountNumber'],
    );
  }
}


