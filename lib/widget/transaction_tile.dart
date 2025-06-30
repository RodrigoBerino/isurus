import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionTile extends StatelessWidget {
  final Transaction transaction;

  const TransactionTile({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.monetization_on),
      title: Text('${transaction.type.name} - R\$ ${transaction.quantity.toStringAsFixed(2)}'),
      subtitle: Text(transaction.description),
      trailing: Text('${transaction.date.day}/${transaction.date.month}/${transaction.date.year}'),
    );
  }
}