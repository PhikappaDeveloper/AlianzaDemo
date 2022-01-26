import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:app_alianzademo/models/user.dart';

class user {
  static Future<Database> initDB() async {
    return openDatabase(join(await getDatabasesPath(), 'users.db'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE user (id TEXT, username TEXT, password TEXT)",
      );
    }, version: 1);
  }

  static Future<int> insert(User user) async {
    Database database = await initDB();
    return database.insert("user", user.toMap());
  }

  static Future<int> delete(String id) async {
    Database database = await initDB();
    return database.delete("user", where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> update(User user) async {
    Database database = await initDB();
    return database.update("user", user.toMap(),
        where: 'id = ?', whereArgs: [user.id]);
  }

  static Future<User> getUserData() async {
    Database database = await initDB();

    final List<Map<String, dynamic>> usersMap = await database.query("user");

    return User(
        id: usersMap[0]['id'],
        username: usersMap[0]['username'],
        password: usersMap[0]['password']);
  }

  static Future<bool> isUserEmpty() async {
    Database database = await initDB();

    final List<Map<String, dynamic>> usersMap = await database.query("user");

    if (usersMap.length == 0) {
      return false;
    } else {
      return true;
    }
  }
}
