import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_finance/models/bank.dart';

class BankDao {
  final String apiUrl = 'https://my-finance-api.fly.dev/banks';

  Future<List<Bank>> getAllBanks() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Bank.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load banks');
    }
  }

  Future<void> insertBank(Bank bank) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(bank.toMap()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to insert bank');
    }
  }

  Future<void> updateBank(Bank bank) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${bank.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(bank.toMap()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update bank');
    }
  }

  Future<void> deleteBank(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete bank');
    }
  }
}
