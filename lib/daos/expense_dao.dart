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

  Future<void> updateExpenseByExcludedCategory(int categoryId) async {
    await db.update('expense', {'category_id': 0},
        where: 'category_id = ?', whereArgs: [categoryId]);
  }

  Future<void> updateExpenseByExcludedBank(int bankId) async {
    await db.update('expense', {'bank_id': 0},
        where: 'bank_id = ?', whereArgs: [bankId]);
  }
}
