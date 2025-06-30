import '../core/enums/account_status.dart';
import 'transaction.dart';

abstract class Conta {
  final String contaNumber;
  ContaStatus status;
  double balance = 0.0;
  List<Transaction> transactions = [];

  Conta(this.contaNumber, this.status);

  void deposit(double amount) {
    balance += amount;
    transactions.add(Transaction.deposit(amount, 'Depósito'));
  }

  void transfer(Conta toConta, double amount) {
    if (balance >= amount) {
      balance -= amount;
      toConta.deposit(amount);
      transactions.add(Transaction.transfer(amount, 'Transferência'));
    }
  }
}