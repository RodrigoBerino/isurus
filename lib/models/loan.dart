
import 'package:uuid/uuid.dart';

class Loan {
  final String loanId;
  final String customerId; // Link to customer
  double principalAmount;
  double interestRate;
  int termMonths;
  double outstandingBalance;

  Loan({
    String? loanId,
    required this.customerId,
    required this.principalAmount,
    required this.interestRate,
    required this.termMonths,
    required this.outstandingBalance,
  }) : loanId = loanId ?? const Uuid().v4();

  void makePayment(double amount) {
    if (amount > 0 && outstandingBalance >= amount) {
      outstandingBalance -= amount;
    } else if (amount > 0 && outstandingBalance < amount) {
      outstandingBalance = 0;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'loanId': loanId,
      'customerId': customerId,
      'principalAmount': principalAmount,
      'interestRate': interestRate,
      'termMonths': termMonths,
      'outstandingBalance': outstandingBalance,
    };
  }

  factory Loan.fromMap(Map<String, dynamic> map) {
    return Loan(
      loanId: map['loanId'],
      customerId: map['customerId'],
      principalAmount: map['principalAmount'],
      interestRate: map['interestRate'],
      termMonths: map['termMonths'],
      outstandingBalance: map['outstandingBalance'],
    );
  }
}

