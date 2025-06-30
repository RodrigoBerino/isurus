import 'package:flutter/material.dart';
import '../services/customer_service.dart';
import '../models/customer.dart';
import '../core/utils/id_generator.dart';

class RegisterScreen extends StatefulWidget {
  final CustomerService customerService;

  const RegisterScreen({super.key, required this.customerService});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _documentController = TextEditingController();
  final _addressController = TextEditingController();

  void _register() {
    final customer = Customer(
      customerId: IdGenerator.generate(),
      name: _nameController.text,
      document: _documentController.text,
      address: _addressController.text,
      email: _emailController.text,
      passwordHash: _passwordController.text,
    );

    widget.customerService.register(customer);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrar')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Nome')),
              TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
              TextField(controller: _passwordController, decoration: InputDecoration(labelText: 'Senha'), obscureText: true),
              TextField(controller: _documentController, decoration: InputDecoration(labelText: 'Documento')),
              TextField(controller: _addressController, decoration: InputDecoration(labelText: 'Endereço')),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _register, child: Text('Registrar')),
            ],
          ),
        ),
      ),
    );
  }
}