import 'package:flutter/material.dart';

void main() {
  runApp(const ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  // ExpenseApp({key? key}):super(key: key);
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const AddExpense());
  }
}

class ExpenseHome extends StatelessWidget {
  const ExpenseHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Expense Tracker")),
      body: Column(
        children: [
          ExpenseCard(title: "Groceries", date: "Jul 23, 2026", amount: 250.0),
          ExpenseCard(
            title: "Electricity Bill",
            date: "Jul 25, 2026",
            amount: 1250,
          ),
        ],
      ),
    );
  }
}

class ExpenseCard extends StatelessWidget {
  final String title;
  final String date;
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
                  date,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
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

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  final _formKey = GlobalKey<FormState>();

  void showDatepicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDate: _selectedDate == null ? DateTime.now() : _selectedDate,
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }

    print("Selected Date $pickedDate");
  }

  void submitForm() {
    if ((_formKey.currentState?.validate() ?? false) && _selectedDate != null) {
      final title = _titleController.text;
      final amount = double.parse(_amountController.text);

      print("Title: $title, Amount: $amount, Date: $_selectedDate");
    }
  }

  void resetForm() {
    _formKey.currentState?.reset();
    _titleController.clear();
    _amountController.clear();
    setState(() {
      _selectedDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Expense")),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "Title"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a title";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Amount"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter an amount";
                }
                if (double.tryParse(value) == null) {
                  return "Please enter a valid number";
                }
                return null;
              },
            ),

            Text(
              _selectedDate == null
                  ? "No Date Chosen"
                  : "Picked Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
            ),

            TextButton(
              onPressed: () => showDatepicker(),
              child: Text("Choose Data"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => submitForm(),
                  child: Text("Add Expense"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigoAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(width: 15.0),
                ElevatedButton(
                  onPressed: () => resetForm(),
                  child: Text("Reset"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
