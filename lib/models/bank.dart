import 'customer.dart';
import 'account.dart';
import 'checking_account.dart';
import 'savings_account.dart';

enum ContaType { CHECKING, SAVINGS }

class Bank {
  final String bankName;
  final List<Customer> customers = [];

  Bank(this.bankName);

  void addCustomer(Customer customer) {
    customers.add(customer);
  }

  Conta createConta(Customer customer, ContaType type) {
    final contaId = 'ACC\${DateTime.now().millisecondsSinceEpoch}';
    switch (type) {
      case ContaType.CHECKING:
        return CheckingConta(contaId, ContaStatus.ACTIVE, 1000);
      case ContaType.SAVINGS:
        return SavingsConta(contaId, ContaStatus.ACTIVE, 0);
    }
  }
}