import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_finance/models/income.dart';
import 'package:my_finance/utils/index.dart';
import 'package:sqflite/sqflite.dart';

class IncomeDao {
  final String apiUrl = 'https://my-finance-api.fly.dev/incomes';
  final Database db;

  IncomeDao(this.db);

  Future<List<Income>> getAllIncomes() async {
    if (await isConnected()) {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final incomes = data.map((json) => Income.fromMap(json)).toList();
        await _saveIncomes(incomes);
        return incomes;
      } else {
        throw Exception('Failed to load incomes');
      }
    } else {
      return _getIncomesFromDb();
    }
  }

  Future<void> insertIncome(Income income) async {
    if (!(await isConnected())) return;
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(income.toMap()),
    );
    if (response.statusCode == 201) {
      await db.insert(
        'incomes',
        income.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      throw Exception('Failed to insert income');
    }
  }

  Future<void> updateIncome(Income income) async {
    if (!(await isConnected())) return;
    final response = await http.put(
      Uri.parse('$apiUrl/${income.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(income.toMap()),
    );
    if (response.statusCode == 200) {
      await db.update(
        'incomes',
        income.toMap(),
        where: "id = ?",
        whereArgs: [income.id],
      );
    } else {
      throw Exception('Failed to update income');
    }
  }

  Future<void> deleteIncome(int id) async {
    if (!(await isConnected())) return;
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode == 200) {
      await db.delete(
        'incomes',
        where: "id = ?",
        whereArgs: [id],
      );
    } else {
      throw Exception('Failed to delete income');
    }
  }

  Future<void> _saveIncomes(List<Income> incomes) async {
    for (var income in incomes) {
      await db.insert(
        'incomes',
        income.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Income>> _getIncomesFromDb() async {
    final List<Map<String, dynamic>> maps = await db.query('incomes');
    return List.generate(maps.length, (i) {
      return Income.fromMap(maps[i]);
    });
  }
}
