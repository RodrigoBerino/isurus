import '../models/customer.dart';

class CustomerService {
  final List<Customer> _customers = [];

  void register(Customer customer) {
    _customers.add(customer);
  }

  Customer? login(String email, String password) {
  try {
    return _customers.firstWhere(
      (c) => c.email == email && c.passwordHash == password,
    );
  } catch (_) {
    return null;
  }
}


  List<Customer> getAll() => _customers;
}
