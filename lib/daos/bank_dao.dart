import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_finance/models/bank.dart';
import 'package:my_finance/utils/index.dart';
import 'package:sqflite/sqflite.dart';

class BankDao {
  final String apiUrl = 'https://my-finance-api.fly.dev/banks';
  final Database db;

  BankDao(this.db);

  Future<List<Bank>> getAllBanks() async {
    if (await isConnected()) {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final banks = data.map((json) => Bank.fromMap(json)).toList();
        await _saveBanks(banks);
        return banks;
      } else {
        throw Exception('Failed to load banks');
      }
    } else {
      return _getBanksFromDb();
    }
  }

  Future<void> insertBank(Bank bank) async {
    if (!(await isConnected())) return;
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(bank.toMap()),
    );
    if (response.statusCode == 201) {
      await db.insert(
        'banks',
        bank.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      throw Exception('Failed to insert bank');
    }
  }

  Future<void> updateBank(Bank bank) async {
    if (!(await isConnected())) return;
    final response = await http.put(
      Uri.parse('$apiUrl/${bank.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(bank.toMap()),
    );
    if (response.statusCode == 200) {
      await db.update(
        'banks',
        bank.toMap(),
        where: "id = ?",
        whereArgs: [bank.id],
      );
    } else {
      throw Exception('Failed to update bank');
    }
  }

  Future<void> deleteBank(int id) async {
    if (!(await isConnected())) return;
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode == 200) {
      await db.delete(
        'banks',
        where: "id = ?",
        whereArgs: [id],
      );
    } else {
      throw Exception('Failed to delete bank');
    }
  }

  Future<void> _saveBanks(List<Bank> banks) async {
    for (var bank in banks) {
      await db.insert(
        'banks',
        bank.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Bank>> _getBanksFromDb() async {
    final List<Map<String, dynamic>> maps = await db.query('banks');
    return List.generate(maps.length, (i) {
      return Bank.fromMap(maps[i]);
    });
  }
}
