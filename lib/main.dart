import 'package:flutter/material.dart';
import 'views/home_view.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Isurus',
      theme: AppTheme.lightTheme,
      home: const HomeView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
