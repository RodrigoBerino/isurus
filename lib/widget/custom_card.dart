import 'package:flutter/material.dart';
import '../models/card.dart';

class CustomCardWidget extends StatelessWidget {
  final CardModel card;

  const CustomCardWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[50],
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Número: ${card.cardNumber}', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Expira: ${card.expirationDate}'),
            Text('Tipo: ${card.cardType.name}'),
            Text('Status: ${card.status.name}'),
          ],
        ),
      ),
    );
  }
}