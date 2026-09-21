import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/user_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('user_management.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL
      )
    ''');
  }

  // CREATE: Tambah Data
  Future<int> createUser(UserModel user) async {
    final db = await instance.database;
    return await db.insert('users', user.toMap());
  }

  // READ: Ambil Semua Data
  Future<List<UserModel>> getAllUsers() async {
    final db = await instance.database;
    final result = await db.query('users', orderBy: 'id DESC');
    return result.map((map) => UserModel.fromMap(map)).toList();
  }

  // UPDATE: Perbarui Data berdasarkan ID
  Future<int> updateUser(UserModel user) async {
    final db = await instance.database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  // DELETE: Hapus Data berdasarkan ID
  Future<int> deleteUser(int id) async {
    final db = await instance.database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
