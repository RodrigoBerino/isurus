import 'package:bank_app/database/database_helper.dart';
import 'package:bank_app/models/loan.dart';

class LoanService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> addLoan(Loan loan) async {
    await _dbHelper.insertLoan(loan);
  }

  Future<List<Loan>> getLoansByCustomerId(String customerId) async {
    return await _dbHelper.getLoansByCustomerId(customerId);
  }

  Future<void> makeLoanPayment(Loan loan, double amount) async {
    loan.makePayment(amount);
    await _dbHelper.updateLoan(loan);
  }
}