import 'package:my_finance/models/category.dart';
import 'package:sqflite/sqflite.dart';

class CategoryDao {
  late Database db;

  CategoryDao(this.db);
  
  Future<List<Category>> getAllCategories() async {
    final result = await db.query('category');
    return result.map((data) => Category.fromMap(data)).toList();
  }

  Future<void> insertCategory(Category category) async {
    await db.insert('category', category.toMap());
  }

  Future<void> deleteCategory(int id) async {
    await db.delete('category', where: 'id = ?', whereArgs: [id]);
  }
}