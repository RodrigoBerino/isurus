import 'package:flutter/material.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Cartões'),
      ),
      body: Center(
        child: Text(
          'Aqui você verá a lista dos seus cartões.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
