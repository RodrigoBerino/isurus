import '../models/transaction.dart';

class TransactionService {
  final List<Transaction> _transactions = [];

  void recordTransaction(Transaction transaction) {
    _transactions.add(transaction);
  }

  List<Transaction> getAll() => _transactions;
}