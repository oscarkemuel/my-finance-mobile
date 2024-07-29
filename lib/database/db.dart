import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  DB._();

  static final DB instance = DB._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'my_finance.db');
    // await deleteDatabase(path);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(_bank);
    await db.execute(_category);
    await db.execute(_income);
    await db.execute(_expense);
    await db.execute(_billet);
    // final tables =
    //     await db.rawQuery('SELECT name FROM sqlite_master WHERE type="table"');
    // print('Tables: $tables');
  }

  String get _bank {
    return '''
      CREATE TABLE banks(
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        balance REAL NOT NULL DEFAULT 0
      )
    ''';
  }

  String get _category {
    return '''
      CREATE TABLE categories(
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        icon TEXT NOT NULL
      )
    ''';
  }

  String get _income {
    return '''
      CREATE TABLE incomes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        amount REAL NOT NULL,
        date TEXT NOT NULL
      )
    ''';
  }

  String get _expense {
    return '''
      CREATE TABLE expenses(
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

  String get _billet {
    return '''
      CREATE TABLE billets(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        code TEXT NOT NULL,
        amount REAL NOT NULL,
        dueDate TEXT NOT NULL,
        company TEXT NOT NULL,
        description TEXT NOT NULL
      )
    ''';
  }
}
