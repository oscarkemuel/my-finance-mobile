import 'package:my_finance/models/income.dart';
import 'package:sqflite/sqflite.dart';

class IncomeDao {
  late Database db;

  IncomeDao(this.db);

  Future<List<Income>> getAllIncomes() async {
    final result = await db.query('income');
    return result.map((data) => Income.fromMap(data)).toList();
  }

  Future<void> insertIncome(Income income) async {
    await db.insert('income', income.toMap());
  }

  Future<void> deleteIncome(int id) async {
    await db.delete('income', where: 'id = ?', whereArgs: [id]);
  }
}
