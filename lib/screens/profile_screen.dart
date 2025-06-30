import 'package:flutter/material.dart';
import '../models/customer.dart';

class ProfileScreen extends StatelessWidget {
  final Customer customer;

  const ProfileScreen({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: ${customer.name}'),
            Text('Email: ${customer.email}'),
            Text('Endereço: ${customer.address}'),
            Text('Documento: ${customer.document}'),
          ],
        ),
      ),
    );
  }
}