import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/note.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, 'note_app.db');

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    try {
      const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
      const textType = 'TEXT NOT NULL';
      const dateTimeType = 'TEXT NOT NULL';

      await db.execute('''
      CREATE TABLE notes (
      id $idType,
      title $textType,
      content $textType,
      create_at $dateTimeType,
      update_at $dateTimeType,
      isCompleted INTEGER NOT NULL DEFAULT 0
      )
    ''');
    } catch (e) {
      throw Exception('loi database: ${e}');
    }
  }

  Future<Database> get database async {
    try {
      if (_database != null) return _database!;

      _database = await _initDB();
      return _database!;
    } catch (e) {
      throw Exception('loi database: ${e}');
    }
  }

  Future<int> create(Note note) async {
    try {
      final db = await database;
      return await db.insert('notes', note.toMap());
    } catch (e) {
      throw Exception('loi database: ${e}');
    }
  }

  Future<List<Note>> readAll() async {
    try {
      final db = await database;
      final maps = await db.query('notes', orderBy: 'update_at DESC');
      return maps.map((m) => Note.fromMap(m)).toList();
    } catch (e) {
      throw Exception('loi database: ${e}');
    }
  }

  Future<int> update(Note note) async {
    try {
      final db = await database;
      return await db.update(
        'notes',
        note.toMap(),
        where: 'id = ?',
        whereArgs: [note.id],
      );
    } catch (e) {
      throw Exception('loi database: ${e}');
    }
  }

  Future<int> delete(int? id) async {
    try {
      if (id != null) {
        final db = await database;
        return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
      } else {
        throw Exception('loi id rong');
      }
    } catch (e) {
      throw Exception('loi database: ${e}');
    }
  }
}
