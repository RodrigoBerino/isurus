import 'package:bank_app/models/account_status.dart';
import 'package:bank_app/models/transaction.dart';



abstract class Account {
  final String accountNumber;
  double balance;
  final DateTime openDate;
  AccountStatus status;

  Account({
    required this.accountNumber,
    required this.balance,
    required this.openDate,
    this.status = AccountStatus.active,
  });

  void deposit(double amount) {
    if (amount > 0) {
      balance += amount;
    }
  }

  void withdraw(double amount) {
    if (amount > 0 && balance >= amount) {
      balance -= amount;
    }
  }

  void transfer(Account toAccount, double amount) {
    if (amount > 0 && balance >= amount) {
      balance -= amount;
      toAccount.balance += amount;
    }
  }

  double getBalance() => balance;

  // This will be implemented later with database integration
  List<Transaction> getStatement() => [];
}


