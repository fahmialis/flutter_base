class ExpenseEntity {
  ExpenseEntity(
      {required this.title,
      required this.amount,
      required this.date,
      this.note});

  final String title;
  final String? note;
  final double amount;
  final DateTime date;
}
