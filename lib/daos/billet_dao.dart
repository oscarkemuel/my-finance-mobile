import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_finance/models/billet.dart';
import 'package:my_finance/utils/index.dart';
import 'package:sqflite/sqflite.dart';

class BilletDao {
  final String apiUrl = 'https://my-finance-api.fly.dev/billets';
  final Database db;

  BilletDao(this.db);

  Future<List<Billet>> getAllBillets() async {
    if (await isConnected()) {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final billets = data.map((json) => Billet.fromMap(json)).toList();
        await _saveBillets(billets);
        return billets;
      } else {
        throw Exception('Failed to load billets');
      }
    } else {
      return _getBilletsFromDb();
    }
  }

  Future<void> insertBillet(Billet billet) async {
    if (!(await isConnected())) return;
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(billet.toMap()),
    );
    if (response.statusCode == 201) {
      await db.insert(
        'billets',
        billet.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      throw Exception('Failed to insert billet');
    }
  }

  Future<void> updateBillet(Billet billet) async {
    if (!(await isConnected())) return;
    final response = await http.patch(
      Uri.parse('$apiUrl/${billet.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(billet.toMap()),
    );
    if (response.statusCode == 200) {
      await db.update(
        'billets',
        billet.toMap(),
        where: "id = ?",
        whereArgs: [billet.id],
      );
    } else {
      throw Exception('Failed to update billet');
    }
  }

  Future<void> deleteBillet(int id) async {
    if (!(await isConnected())) return;
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode == 200) {
      await db.delete(
        'billets',
        where: "id = ?",
        whereArgs: [id],
      );
    } else {
      throw Exception('Failed to delete billet');
    }
  }

  Future<void> _saveBillets(List<Billet> billets) async {
    for (var billet in billets) {
      await db.insert(
        'billets',
        billet.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Billet>> _getBilletsFromDb() async {
    final List<Map<String, dynamic>> maps = await db.query('billets');
    return List.generate(maps.length, (i) {
      return Billet.fromMap(maps[i]);
    });
  }
}
