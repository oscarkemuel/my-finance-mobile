import 'package:my_finance/models/expense.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseDao {
  late Database db;

  ExpenseDao(this.db);

  Future<List<Expense>> getAllExpenses() async {
    final result = await db.query('expense');
    return result.map((data) => Expense.fromMap(data)).toList();
  }

  Future<void> insertExpense(Expense expense) async {
    await db.insert('expense', expense.toMap());
  }

  Future<void> deleteExpense(int id) async {
    await db.delete('expense', where: 'id = ?', whereArgs: [id]);
  }
}
