class Expense {
  int id;
  String name;
  double amount;
  DateTime date;
  DateTime createdDate;
  int categoryId;
  int bankId;

  Expense({
    required this.id,
    required this.name,
    required this.amount,
    required this.date,
    required this.categoryId,
    required this.bankId,
    required this.createdDate,
  });

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      name: map['name'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      createdDate: DateTime.parse(map['created_date']),
      categoryId: map['category_id'],
      bankId: map['bank_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'date': date.toIso8601String(),
      'created_date': createdDate.toIso8601String(),
      'category_id': categoryId,
      'bank_id': bankId,
    };
  }
}
