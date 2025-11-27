import 'package:flutter/material.dart';
import 'screens/root_screen.dart';

void main() {
  runApp(const AmiiboApp());
}

class AmiiboApp extends StatelessWidget {
  const AmiiboApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: const RootScreen(),
    );
  }
}
