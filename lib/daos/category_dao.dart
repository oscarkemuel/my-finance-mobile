import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_finance/models/category.dart';

class CategoryDao {
  final String apiUrl = 'http://localhost:3000/categories';

  Future<List<Category>> getAllCategories() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Category.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<void> insertCategory(Category category) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(category.toMap()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to insert category');
    }
  }

  Future<void> updateCategory(Category category) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${category.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(category.toMap()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update category');
    }
  }

  Future<void> deleteCategory(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete category');
    }
  }
}
