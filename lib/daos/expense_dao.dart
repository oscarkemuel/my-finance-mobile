import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_finance/models/expense.dart';

class ExpenseDao {
  final String apiUrl = 'https://my-finance-api.fly.dev/expenses';

  Future<List<Expense>> getAllExpenses() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Expense.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load expenses');
    }
  }

  Future<void> insertExpense(Expense expense) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(expense.toMap()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to insert expense');
    }
  }

  Future<void> updateExpense(Expense expense) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${expense.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(expense.toMap()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update expense');
    }
  }

  Future<void> deleteExpense(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete expense');
    }
  }

  Future<void> updateExpenseByExcludedCategory(int categoryId) async {
    final response = await http.patch(
      Uri.parse('$apiUrl/update-by-category/$categoryId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'category_id': 0}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update expenses by excluded category');
    }
  }

  Future<void> updateExpenseByExcludedBank(int bankId) async {
    final response = await http.patch(
      Uri.parse('$apiUrl/update-by-bank/$bankId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'bank_id': 0}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update expenses by excluded bank');
    }
  }
}
