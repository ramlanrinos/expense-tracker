import 'package:flutter/material.dart';
import '../models/expense_model.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;

  // A key used to identify and manage the state of the Form widget in UI.
  // _formKey.currentState?.validate() → to check if inputs are valid.
  // _formKey.currentState?.reset() → to clear the form.
  final _formKey = GlobalKey<FormState>();

  void showDatepicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDate: _selectedDate ?? DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }

    // print("Selected Date $pickedDate");
  }

  void submitForm() {
    if ((_formKey.currentState?.validate() ?? false) && _selectedDate != null) {
      final title = _titleController.text;
      final amount = double.parse(_amountController.text);

      // print("Title $title");
      // print("Amount $amount");
      // print("Date $_selectedDate");

      // final newExpense = {
      //   "title": title,
      //   "date": _selectedDate,
      //   "amount": amount,
      // };

      final newExpense = ExpenseModel(
        title: title,
        date: _selectedDate,
        amount: amount,
      );

      Navigator.pop(context, newExpense);
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
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, style: BorderStyle.solid),
                  ),
                ),
                controller: _titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Title is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Amount",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, style: BorderStyle.solid),
                  ),
                ),
                controller: _amountController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Amount is required";
                  }
                  if (double.tryParse(value) == null) {
                    return "Enter a number";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Text(
                _selectedDate == null
                    ? "No date selected"
                    : "Selected Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
              ),
              TextButton(
                onPressed: () => showDatepicker(),
                child: Text("Select Date"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => submitForm(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigoAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text("Add Expense"),
                  ),
                  SizedBox(width: 15.0),
                  ElevatedButton(
                    onPressed: () => resetForm(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text("Rest"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
