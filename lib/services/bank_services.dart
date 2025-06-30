import '../models/bank.dart';
import '../models/customer.dart';
import '../models/account.dart';

class BankService {
  final Bank _bank;

  BankService(String bankName) : _bank = Bank(bankName);

  void addCustomer(Customer customer) {
    _bank.addCustomer(customer);
  }

  Conta createConta(Customer customer, ContaType type) {
    return _bank.createConta(customer, type);
  }

  List<Customer> getCustomers() => _bank.customers;
}