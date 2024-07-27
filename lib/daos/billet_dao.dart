import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_finance/models/billet.dart';

class BilletDao {
  final String apiUrl = 'https://my-finance-api.fly.dev/billets';

  Future<List<Billet>> getAllBillets() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Billet.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load billets');
    }
  }

  Future<void> insertBillet(Billet billet) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(billet.toMap()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to insert billet');
    }
  }

  Future<void> updateBillet(Billet billet) async {
    final response = await http.patch(
      Uri.parse('$apiUrl/${billet.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(billet.toMap()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update billet');
    }
  }

  Future<void> deleteBillet(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete billet');
    }
  }
}
