class Income {
  int id;
  String name;
  double amount;
  DateTime date;

  Income({
    required this.id,
    required this.name,
    required this.amount,
    required this.date,
  });

  factory Income.fromMap(Map<String, dynamic> map) {
    return Income(
      id: map['id'],
      name: map['name'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }
}
