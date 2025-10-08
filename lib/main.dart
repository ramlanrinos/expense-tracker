import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'screens/add_expense_screen.dart';
import 'screens/home_screen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  Hive.registerAdapter(ExpenseModelAdapter());
  await Hive.openBox<ExpenseModel>("expenses");
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
