import 'package:bank_app/database/database_helper.dart';
import 'package:bank_app/models/account.dart';
import 'package:bank_app/models/checking_account.dart';
import 'package:bank_app/models/savings_account.dart';

class AccountService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> createAccount(Account account, String customerId) async {
    await _dbHelper.insertAccount(account, customerId);
  }

  Future<List<Account>> getAccountsByCustomerId(String customerId) async {
    return await _dbHelper.getAccountsByCustomerId(customerId);
  }

  Future<void> updateAccount(Account account) async {
    await _dbHelper.updateAccount(account);
  }

  Future<void> deleteAccount(String accountNumber) async {
    await _dbHelper.deleteAccount(accountNumber);
  }

  Future<void> deposit(Account account, double amount) async {
    account.deposit(amount);
    await _dbHelper.updateAccount(account);
  }

  Future<void> withdraw(Account account, double amount) async {
    account.withdraw(amount);
    await _dbHelper.updateAccount(account);
  }

  Future<void> transfer(Account fromAccount, Account toAccount, double amount) async {
    fromAccount.transfer(toAccount, amount);
    await _dbHelper.updateAccount(fromAccount);
    await _dbHelper.updateAccount(toAccount);
  }
}