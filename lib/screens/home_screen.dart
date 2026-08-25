import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  List<ExpenseModel> expenses = [
    ExpenseModel(title: "Groceries", amount: 250.0, date: DateTime.now()),
    ExpenseModel(
      title: "Electricity Bill",
      amount: 1250.0,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newExpense =
              await Navigator.pushNamed(context, "/add-expense")
                  as ExpenseModel;
          print(
            "New Expense: ${newExpense.title}, ${newExpense.amount}, ${newExpense.date}",
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.indigoAccent,
        foregroundColor: Colors.white,
      ),

      appBar: AppBar(title: Text("Expense Tracker")),

      // body: Column(
      //   children: [
      //     ExpenseCard(title: "Groceries", date: "Jul 23, 2026", amount: 250.0),
      //     ExpenseCard(
      //       title: "Electricity Bill",
      //       date: "Jul 25, 2026",
      //       amount: 1250,
      //     ),
      //   ],
      // ),
      body: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          final expense = expenses[index];
          return ExpenseCard(
            title: expense.title,
            date: expense.date,
            amount: expense.amount,
          );
        },
      ),
    );
  }
}

class ExpenseCard extends StatelessWidget {
  final String title;
  final DateTime? date;
  final double amount;

  const ExpenseCard({
    required this.title,
    required this.date,
    required this.amount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20.0),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 5),

                Text(
                  "{$date.!month}, ${date!.day}, ${date!.year}",
                  style: TextStyle(fontSize: 16, color: Colors.red[300]),
                ),
              ],
            ),
            Container(
              child: Text(
                "\₹ ${amount.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
            ),
          ],
        ),
      ),
    );
  }
}
