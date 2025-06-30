import 'package:bank_app/database/database_helper.dart';
import 'package:bank_app/models/customer.dart';

class CustomerService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<Customer?> registerCustomer(Customer customer) async {
    final existingCustomer = await _dbHelper.getCustomerByEmail(customer.email);
    if (existingCustomer != null) {
      return null; // Customer with this email already exists
    }
    await _dbHelper.insertCustomer(customer);
    return customer;
  }

  Future<Customer?> loginCustomer(String email, String password) async {
    final customer = await _dbHelper.getCustomerByEmail(email);
    if (customer != null && customer.login(email, password)) {
      return customer;
    }
    return null;
  }

  Future<bool> updateCustomerProfile(Customer customer) async {
    final result = await _dbHelper.updateCustomer(customer);
    return result > 0;
  }

  Future<Customer?> getCustomerById(String customerId) async {
    // This method is not directly in DatabaseHelper, but can be added if needed.
    // For now, we'll assume we get customer by email for login/registration.
    // If needed, we can add a getCustomerById to DatabaseHelper.
    return null; 
  }
}