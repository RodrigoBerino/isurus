import 'package:bank_app/models/account.dart';

class CheckingAccount extends Account {
  double overdraftLimit;

  CheckingAccount({
    required String accountNumber,
    required double balance,
    required DateTime openDate,
    required this.overdraftLimit,
  }) : super(
          accountNumber: accountNumber,
          balance: balance,
          openDate: openDate,
        );

  @override
  void withdraw(double amount) {
    if (amount > 0 && (balance + overdraftLimit) >= amount) {
      balance -= amount;
    } else {
      // Handle insufficient funds
      print('Insufficient funds, even with overdraft limit.');
    }
  }
}