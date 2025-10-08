import 'package:flutter/material.dart';
import 'screens/add_expense_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({
    super.key,
  }); // here we don't need build object again and again thats why use const

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: const HomeScreen(),
      routes: {
        "/": (context) => HomeScreen(),
        "/add-expense": (context) => AddExpenseScreen(),
      },
    );
  }
}
