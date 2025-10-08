import 'package:hive/hive.dart';

part 'expense_model.g.dart';

@HiveType(typeId: 0)
class ExpenseModel extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final DateTime? date;
  @HiveField(2)
  final double amount;

  ExpenseModel({required this.title, required this.date, required this.amount});
}
