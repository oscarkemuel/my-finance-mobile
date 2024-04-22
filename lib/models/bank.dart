class Bank {
  int id;
  String name;
  double balance;

  Bank({
    required this.id,
    required this.name,
    required this.balance,
  });

  factory Bank.fromMap(Map<String, dynamic> map) {
    return Bank(
      id: map['id'],
      name: map['name'],
      balance: map['balance'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'balance': balance,
    };
  }
}
