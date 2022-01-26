import 'dart:async';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:app_alianzademo/models/prestamo.dart';

class prestamo {

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE prestamos(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        prestamo TEXT,
        pago TEXT,
        fecha TEXT
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'prestamos.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createItem(String? prestamos, String? pago, String? fecha) async {
    final db = await prestamo.db();

    final data = {'prestamo': prestamos, 'pago': pago, 'fecha':fecha};
    final id = await db.insert('prestamos', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> updateItem(int id, String prestamos, String? pago, String? fecha) async {
    final db = await prestamo.db();

    final data = {
      'prestamo': prestamos,
      'pago': pago,
      'fecha': fecha
    };

    final result = await db.update('prestamos', data, where: "id = ?", whereArgs: [id]);

    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await prestamo.db();
    try {
      await db.delete("prestamos", where: "id = ?", whereArgs: [id]);
    } 
    catch (err) {}
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await prestamo.db();
    return db.query('prestamos', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await prestamo.db();
    return db.query('prestamos', orderBy: "id");
  }

}
