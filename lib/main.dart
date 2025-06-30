import 'package:flutter/material.dart';
import 'services/customer_service.dart';
import 'screens/login_screen.dart';

void main() {
  final customerService = CustomerService();
  runApp(MyApp(customerService: customerService));
}

class MyApp extends StatelessWidget {
  final CustomerService customerService;

  const MyApp({required this.customerService, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banco Isurus',
      home: LoginScreen(customerService: customerService),
    );
  }
}
