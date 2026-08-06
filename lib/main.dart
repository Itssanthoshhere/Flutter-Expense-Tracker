import 'package:expense_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'screens/add_expense_screen.dart';

void main() {
  runApp(const ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  // ExpenseApp({key? key}):super(key: key);
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => HomeScreen(),
        "/add-expense": (context) => AddExpenseScreen(),
      },
    );
  }
}
