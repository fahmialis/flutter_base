import 'package:flutter/material.dart';
import 'package:roll_dice/feature/expenses/data/entities/expense_entitites.dart';
import 'package:roll_dice/feature/expenses/feature/widgets/expense_card.dart';
import 'package:roll_dice/feature/expenses/feature/widgets/expense_modal.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key, required this.title});
  final String title;

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  List<ExpenseEntity> expenses = [
    ExpenseEntity(
        title: 'test', amount: 123, date: DateTime.now(), note: 'with note'),
    ExpenseEntity(title: 'test2', amount: 1234, date: DateTime.now()),
  ];

  void addExpense(ExpenseEntity newExpense) {
    setState(() {
      expenses.add(ExpenseEntity(
          title: newExpense.title,
          amount: newExpense.amount,
          date: newExpense.date,
          note: newExpense.note ?? ''));
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('New expense added')));
  }

  void deleteExpense(ExpenseEntity removedExpense) {
    final expenseIndex = expenses.indexOf(removedExpense);
    setState(() {
      expenses.remove(removedExpense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Expenses removed'),
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              expenses.insert(expenseIndex, removedExpense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[50],
        onPressed: () {
          openModalExpense(context, addExpense);
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: expenses.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Dismissible(
                    key: Key(expenses[index].date.toString()),
                    onDismissed: (direction) {
                      deleteExpense(expenses[index]);
                    },
                    child: ExpenseCard(expense: expenses[index]));
              },
            )
          ],
        ),
      ),
    );
  }
}
