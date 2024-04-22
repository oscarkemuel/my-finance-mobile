import 'package:my_finance/utils/index.dart';

class Category {
  int id;
  String name;
  CategoryIdentifier icon;

  Category({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
       icon: Utils.stringToCategoryIdentifier(map['icon'] as String)
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon.toString().split('.').last
    };
  }
}
