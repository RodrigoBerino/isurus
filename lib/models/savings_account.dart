import 'package:bank_app/models/account.dart';

class SavingsAccount extends Account {
  double interestRate;

  SavingsAccount({
    required String accountNumber,
    required double balance,
    required DateTime openDate,
    required this.interestRate,
  }) : super(
          accountNumber: accountNumber,
          balance: balance,
          openDate: openDate,
        );

  void applyInterest() {
    balance += balance * interestRate;
  }
}


