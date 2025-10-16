import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const SobatSadarApp());
}

class SobatSadarApp extends StatelessWidget {
  const SobatSadarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sobat Sadar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SplashScreen(),
    );
  }
}
