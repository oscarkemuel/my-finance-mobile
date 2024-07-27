import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_finance/models/expense.dart';
import 'package:my_finance/utils/index.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseDao {
  final String apiUrl = 'https://my-finance-api.fly.dev/expenses';
  final Database db;

  ExpenseDao(this.db);

  Future<List<Expense>> getAllExpenses() async {
    if (await isConnected()) {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final expenses = data.map((json) => Expense.fromMap(json)).toList();
        await _saveExpenses(expenses);
        return expenses;
      } else {
        throw Exception('Failed to load expenses');
      }
    } else {
      return _getExpensesFromDb();
    }
  }

  Future<void> insertExpense(Expense expense) async {
    if (!(await isConnected())) return;
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(expense.toMap()),
    );
    if (response.statusCode == 201) {
      await db.insert(
        'expenses',
        expense.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      throw Exception('Failed to insert expense');
    }
  }

  Future<void> updateExpense(Expense expense) async {
    if (!(await isConnected())) return;
    final response = await http.put(
      Uri.parse('$apiUrl/${expense.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(expense.toMap()),
    );
    if (response.statusCode == 200) {
      await db.update(
        'expenses',
        expense.toMap(),
        where: "id = ?",
        whereArgs: [expense.id],
      );
    } else {
      throw Exception('Failed to update expense');
    }
  }

  Future<void> deleteExpense(int id) async {
    if (!(await isConnected())) return;
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode == 200) {
      await db.delete(
        'expenses',
        where: "id = ?",
        whereArgs: [id],
      );
    } else {
      throw Exception('Failed to delete expense');
    }
  }

  Future<void> updateExpenseByExcludedCategory(int categoryId) async {
    if (!(await isConnected())) return;
    final response = await http.patch(
      Uri.parse('$apiUrl/update-by-category/$categoryId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'category_id': 0}),
    );
    if (response.statusCode == 200) {
      await db.rawUpdate(
        'UPDATE expenses SET category_id = ? WHERE category_id = ?',
        [0, categoryId],
      );
    } else {
      throw Exception('Failed to update expenses by excluded category');
    }
  }

  Future<void> updateExpenseByExcludedBank(int bankId) async {
    if (!(await isConnected())) return;
    final response = await http.patch(
      Uri.parse('$apiUrl/update-by-bank/$bankId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'bank_id': 0}),
    );
    if (response.statusCode == 200) {
      await db.rawUpdate(
        'UPDATE expenses SET bank_id = ? WHERE bank_id = ?',
        [0, bankId],
      );
    } else {
      throw Exception('Failed to update expenses by excluded bank');
    }
  }

  Future<void> _saveExpenses(List<Expense> expenses) async {
    for (var expense in expenses) {
      await db.insert(
        'expenses',
        expense.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Expense>> _getExpensesFromDb() async {
    final List<Map<String, dynamic>> maps = await db.query('expenses');
    return List.generate(maps.length, (i) {
      return Expense.fromMap(maps[i]);
    });
  }
}
