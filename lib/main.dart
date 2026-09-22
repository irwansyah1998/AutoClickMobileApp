import 'package:autoclickmobileapp/core/theme/app_theme.dart';
import 'package:autoclickmobileapp/features/clicker/presentation/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AutoClickApp());
}

class AutoClickApp extends StatelessWidget {
  const AutoClickApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auto Clicker',
      theme: AppTheme.dark,
      home: const HomePage(),
    );
  }
}
