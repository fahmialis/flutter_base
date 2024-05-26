import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:roll_dice/feature/expenses/data/entities/expense_entitites.dart';

Future<dynamic> openModalExpense(
    BuildContext context, Function(Expense newExpense) addExpense) {
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  final amountController = TextEditingController();
  final now = DateTime.now();
  final firstDate = DateTime(now.year - 1, now.month, now.day);
  DateTime? selectedDate;
  Category _selectedCategory = Category.leisure;

  return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      isScrollControlled: true,
      builder: (context) {
        double screenWidth = MediaQuery.of(context).size.width;

        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(child: StatefulBuilder(
            builder: (context, modalState) {
              return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  width: screenWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        maxLength: 50,
                        textAlign: TextAlign.start,
                        decoration: const InputDecoration(label: Text('Title')),
                        controller: titleController,
                      ),
                      TextField(
                        maxLength: 50,
                        textAlign: TextAlign.start,
                        decoration: const InputDecoration(label: Text('Note')),
                        controller: noteController,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              textAlign: TextAlign.start,
                              decoration: const InputDecoration(
                                  label: Text('Amount'), prefixText: 'Rp. '),
                              keyboardType: TextInputType.number,
                              controller: amountController,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                              child: InkWell(
                                  onTap: () async {
                                    final pickedDate = await showDatePicker(
                                      context: context,
                                      firstDate: firstDate,
                                      lastDate: now,
                                    );

                                    modalState(() {
                                      selectedDate = pickedDate;
                                    });
                                  },
                                  child: Text(DateFormat("dd MMM yyyy").format(
                                      selectedDate ?? DateTime.now())))),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          DropdownButton(
                            value: _selectedCategory,
                            items: Category.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Row(
                                      children: [
                                        Text(
                                          category.name.toUpperCase(),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              modalState(() {
                                _selectedCategory = value;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              context.pop();
                            },
                            child: const Chip(label: Text('Cancel')),
                          ),
                          InkWell(
                            onTap: () {
                              addExpense(Expense(
                                  amount: amountController.text.isNotEmpty
                                      ? double.parse(amountController.text)
                                      : 0,
                                  title: titleController.text,
                                  date: selectedDate ?? DateTime.now(),
                                  category: _selectedCategory));
                              context.pop();
                            },
                            child: const Chip(label: Text('Save')),
                          ),
                        ],
                      )
                    ],
                  ));
            },
          )),
        );
      });
}
