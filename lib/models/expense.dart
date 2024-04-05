class Expense {
  int id;
  String name;
  double amount;
  DateTime date;
  DateTime createdDate = DateTime.now();
  int categoryId;
  int bankId;

  Expense({
    required this.id,
    required this.name,
    required this.amount,
    required this.date,
    required this.categoryId,
    required this.bankId,
  });
}
