import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:roll_dice/feature/expenses/data/entities/expense_entitites.dart';
import 'package:roll_dice/helpers/currency.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({super.key, required this.expense, this.text});

  final String? text;
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: screenWidth,
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        DateFormat("dd MMM yyyy").format(expense.date),
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            expense.title,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    CurrencyFormat.convertToIdr(expense.amount, 0),
                    style: const TextStyle(color: Colors.black),
                  ),
                  Icon(categoryIcons[expense.category]),
                ],
              )),
        ],
      ),
    );
  }
}
