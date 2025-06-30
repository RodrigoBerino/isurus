import 'package:bank_app/database/database_helper.dart';
import 'package:bank_app/models/transaction.dart';

class TransactionService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> addTransaction(Transaction transaction) async {
    await _dbHelper.insertTransaction(transaction);
  }

  Future<List<Transaction>> getTransactionsByAccountNumber(String accountNumber) async {
    return await _dbHelper.getTransactionsByAccountNumber(accountNumber);
  }
}