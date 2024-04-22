import 'package:my_finance/models/bank.dart';
import 'package:sqflite/sqflite.dart';

class BankDao {
  late Database db;

  BankDao(this.db);
  
  Future<List<Bank>> getAllBanks() async {
    final result = await db.query('bank');
    return result.map((data) => Bank.fromMap(data)).toList();
  }

  Future<void> insertBank(Bank bank) async {
    await db.insert('bank', bank.toMap());
  }

  Future<void> deleteBank(int id) async {
    await db.delete('bank', where: 'id = ?', whereArgs: [id]);
  }
}
