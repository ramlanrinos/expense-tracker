import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ExpenseModel> expenses = [
    ExpenseModel(title: "Food", date: DateTime.now(), amount: 250.0),
  ];

  final double totalBudget = 5000;
  // fold() is a method available on all Dart lists.
  // It is used to combine (or reduce) all elements of a list into a single value.
  // list.fold(initialValue, (previousValue, element) => newValue)
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
          setState(() {
            expenses.add(newExpense);
          });
          // print("New Expense $newExpense");
        },
        backgroundColor: Colors.indigoAccent,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(title: Text("Expense Tracker")),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total Expenses: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    children: [
                      TextSpan(
                        text: "\$${totalExpense.toStringAsFixed(2)}",
                        style: TextStyle(fontSize: 16, color: Colors.redAccent),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    text: "Balance: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    children: [
                      TextSpan(
                        text: "\$${balance.toStringAsFixed(2)}",
                        style: TextStyle(fontSize: 16, color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
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

  String get formatedDate {
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
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // SizedBox(height: 5),
                Text(
                  formatedDate,
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(4.0),
              ),
              padding: EdgeInsets.all(8.0),
              child: Text(
                "\$${amount.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
