import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

class DB {
  DB._();

  static final DB instance = DB._();

  static  Database? _database;

  get database async {
    if (_database != null) return _database;

    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'my_finance.db'),
      version: 1,
      onCreate: _onCreate,
    );
    // return await deleteDatabase(join(await getDatabasesPath(), 'my_finance.db'));
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(_bank);
    await db.insert('bank', {
      'id': 0,
      'name': 'Desconhecido',
      'balance': 0,
    });

    await db.execute(_category);
    await db.insert('category', {
      'id': 0,
      'name': 'Desconhecida',
      'icon': Icons.help.codePoint,
    });
    List<Map<String, dynamic>> categories = [
      {'name': 'Comida', 'icon': Icons.food_bank.codePoint},
      {'name': 'Transporte', 'icon': Icons.directions_bus.codePoint},
      {'name': 'Saúde', 'icon': Icons.local_hospital.codePoint},
      {'name': 'Educação', 'icon': Icons.school.codePoint},
      {'name': 'Entretenimento', 'icon': Icons.movie.codePoint},
      {'name': 'Serviços', 'icon': Icons.settings.codePoint},
      {'name': 'Outros', 'icon': Icons.more_horiz.codePoint},
    ];
    var timestamp = DateTime.now().millisecondsSinceEpoch;
    for (var category in categories) {
      await db.insert('category', {
        'id': timestamp++,
        'name': category['name'],
        'icon': category['icon'],
      });
    }

    await db.execute(_income);
    await db.execute(_expense);
  }

  String get _bank {
    return '''
      CREATE TABLE bank(
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        balance REAL NOT NULL DEFAULT 0
      )
    ''';
  }

  String get _category {
    return '''
      CREATE TABLE category(
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        icon INTEGER NOT NULL
      )
    ''';
  }

  String get _income {
    return '''
      CREATE TABLE income(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        amount REAL NOT NULL,
        date TEXT NOT NULL
      )
    ''';
  }

  String get _expense {
    return '''
      CREATE TABLE expense(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        amount REAL NOT NULL,
        date TEXT NOT NULL,
        created_date TEXT NOT NULL,
        category_id INTEGER NOT NULL,
        bank_id INTEGER NOT NULL,
        FOREIGN KEY (category_id) REFERENCES category (id),
        FOREIGN KEY (bank_id) REFERENCES bank (id)
      )
    ''';
  }
}