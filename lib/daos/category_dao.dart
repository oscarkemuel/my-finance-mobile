import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_finance/models/category.dart';
import 'package:my_finance/utils/index.dart';
import 'package:sqflite/sqflite.dart';

class CategoryDao {
  final String apiUrl = 'https://my-finance-api.fly.dev/categories';
  final Database db;

  CategoryDao(this.db);

  Future<List<Category>> getAllCategories() async {
    if (await isConnected()) {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final categories = data.map((json) => Category.fromMap(json)).toList();
        await _saveCategories(categories);
        return categories;
      } else {
        throw Exception('Failed to load categories');
      }
    } else {
      return _getCategoriesFromDb();
    }
  }

  Future<void> insertCategory(Category category) async {
    if (!(await isConnected())) return;
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(category.toMap()),
    );
    if (response.statusCode == 201) {
      await db.insert(
        'categories',
        category.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      throw Exception('Failed to insert category');
    }
  }

  Future<void> updateCategory(Category category) async {
    if (!(await isConnected())) return;
    final response = await http.put(
      Uri.parse('$apiUrl/${category.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(category.toMap()),
    );
    if (response.statusCode == 200) {
      await db.update(
        'categories',
        category.toMap(),
        where: "id = ?",
        whereArgs: [category.id],
      );
    } else {
      throw Exception('Failed to update category');
    }
  }

  Future<void> deleteCategory(int id) async {
    if (!(await isConnected())) return;
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode == 200) {
      await db.delete(
        'categories',
        where: "id = ?",
        whereArgs: [id],
      );
    } else {
      throw Exception('Failed to delete category');
    }
  }

  Future<void> _saveCategories(List<Category> categories) async {
    for (var category in categories) {
      await db.insert(
        'categories',
        category.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Category>> _getCategoriesFromDb() async {
    final List<Map<String, dynamic>> maps = await db.query('categories');
    return List.generate(maps.length, (i) {
      return Category.fromMap(maps[i]);
    });
  }
}
