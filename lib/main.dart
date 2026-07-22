import 'package:flutter/material.dart';

void main() {
  runApp(const ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  // ExpenseApp({key? key}):super(key: key);
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Text("Hello Sandy"));
  }
}

class ExpenseHome extends StatelessWidget {
  const ExpenseHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Text("Hello Sandy"));
  }
}
