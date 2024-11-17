import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;

  DBHelper._internal();

  late Database _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = await _initDatabase();
    return _db;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'shopping_app.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE products (id INTEGER PRIMARY KEY, name TEXT, image TEXT, price REAL)',
        );
        await db.insert('products', {
          'id': 1,
          'name': 'Product 1',
          'image': 'assets/product1.png',
          'price': 99.99,
        });
        await db.insert('products', {
          'id': 2,
          'name': 'Product 2',
          'image': 'assets/product2.png',
          'price': 49.99,
        });
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    if (kIsWeb || Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      print("Database not supported on web!");
      return [];
    }
    final db = await database;
    return db.query('products');
  }
}
