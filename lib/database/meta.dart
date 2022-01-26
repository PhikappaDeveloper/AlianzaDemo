import 'dart:async';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:app_alianzademo/models/meta.dart';

class meta {

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE metas(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        meta TEXT,
        ahorro TEXT,
        fecha TEXT
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'metas.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createItem(String? metas, String? ahorro, String? fecha) async {
    final db = await meta.db();

    final data = {'meta': metas, 'ahorro': ahorro, 'fecha':fecha};
    final id = await db.insert('metas', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

    static Future<int> updateItem(int id, String metas, String? ahorro, String? fecha) async {
    final db = await meta.db();

    final data = {
      'metas': metas,
      'ahorro': ahorro,
      'fecha': fecha
    };

    final result = await db.update('metas', data, where: "id = ?", whereArgs: [id]);

    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await meta.db();
    try {
      await db.delete("metas", where: "id = ?", whereArgs: [id]);
    } 
    catch (err) {}
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await meta.db();
    return db.query('metas', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await meta.db();
    return db.query('metas', orderBy: "id");
  }

}
