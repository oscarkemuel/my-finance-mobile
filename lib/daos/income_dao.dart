import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_finance/models/income.dart';

class IncomeDao {
  final String apiUrl = 'http://localhost:3000/incomes';

  Future<List<Income>> getAllIncomes() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Income.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load incomes');
    }
  }

  Future<void> insertIncome(Income income) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(income.toMap()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to insert income');
    }
  }

  Future<void> updateIncome(Income income) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${income.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(income.toMap()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update income');
    }
  }

  Future<void> deleteIncome(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete income');
    }
  }
}
