import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final List<ExpenseModel> expenses = [
  //   ExpenseModel(title: "Groceries", amount: 250.0, date: DateTime.now()),
  //   ExpenseModel(
  //     title: "Electricity Bill",
  //     amount: 1250.0,
  //     date: DateTime.now().subtract(Duration(days: 1)),
  //   ),
  // ];

  final expenseBox = Hive.box<ExpenseModel>("expenses");
  List<ExpenseModel> get expenses => expenseBox.values.toList();

  final double totalBudget = 5000.0;
  double get totalExpense =>
      expenses.fold(0.0, (sum, item) => sum + item.amount);

  double get balance => totalBudget - totalExpense;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newExpense =
              await Navigator.pushNamed(context, "/add-expense")
                  as ExpenseModel;

          // print(
          //   "New Expense: ${newExpense.title}, ${newExpense.amount}, ${newExpense.date}",
          // );

          setState(() {
            // expenses.add(newExpense);
            expenseBox.add(newExpense);
          });
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
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.indigoAccent,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "Total Expense",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "₹${totalExpense.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Balance",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "₹${balance.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: balance >= 0
                            ? Colors.greenAccent
                            : Colors.redAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
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
          ),
        ],
      ),
    );
  }
}

class ExpenseCard extends StatelessWidget {
  final String title;
  final DateTime? date;
  final double amount;

  String get formattedDate {
    return date == null ? "No Date" : DateFormat("MMM d, y").format(date!);
  }

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
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 5),

                  Text(
                    formattedDate,
                    style: TextStyle(fontSize: 16, color: Colors.red[300]),
                  ),
                ],
              ),
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
