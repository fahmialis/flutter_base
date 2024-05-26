import 'package:flutter/material.dart';
import 'package:roll_dice/feature/expenses/data/entities/expense_entitites.dart';
import 'package:roll_dice/feature/expenses/feature/widgets/chart/chart.dart';
import 'package:roll_dice/feature/expenses/feature/widgets/expense_card.dart';
import 'package:roll_dice/feature/expenses/feature/widgets/expense_modal.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key, required this.title});
  final String title;

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  List<Expense> expensesList = [
    Expense(
        title: 'expense 1',
        amount: 5000,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'expense 2',
        amount: 10000,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void addExpense(Expense newExpense) {
    setState(() {
      expensesList.add(Expense(
          title: newExpense.title,
          amount: newExpense.amount,
          date: newExpense.date,
          category: Category.food));
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('New expense added')));
  }

  void deleteExpense(Expense removedExpense) {
    final expenseIndex = expensesList.indexOf(removedExpense);
    setState(() {
      expensesList.remove(removedExpense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Expenses removed'),
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              expensesList.insert(expenseIndex, removedExpense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    bool isPotrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[50],
        foregroundColor: Colors.black,
        onPressed: () {
          openModalExpense(context, addExpense);
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: isPotrait == true
            ? Column(
                children: [
                  Chart(expenses: expensesList),
                  const SizedBox(
                    height: 8,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: expensesList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Dismissible(
                          key: Key(expensesList[index].date.toString()),
                          onDismissed: (direction) {
                            deleteExpense(expensesList[index]);
                          },
                          child: ExpenseCard(
                            expense: expensesList[index],
                          ));
                    },
                  )
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: expensesList)),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: expensesList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Dismissible(
                            key: Key(expensesList[index].date.toString()),
                            onDismissed: (direction) {
                              deleteExpense(expensesList[index]);
                            },
                            child: ExpenseCard(
                              expense: expensesList[index],
                            ));
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
