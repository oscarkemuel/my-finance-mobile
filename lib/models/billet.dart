class Billet {
  int id;
  String code;
  double amount;
  DateTime dueDate;
  String company;
  String description;

  Billet({
    required this.id,
    required this.code,
    required this.amount,
    required this.dueDate,
    required this.company,
    required this.description,
  });

  factory Billet.fromMap(Map<String, dynamic> map) {
    return Billet(
      id: map['id'],
      code: map['code'],
      amount: map['amount'].toDouble(),
      dueDate: DateTime.parse(map['dueDate']),
      company: map['company'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'amount': amount,
      'dueDate': dueDate.toIso8601String(),
      'company': company,
      'description': description,
    };
  }
}
