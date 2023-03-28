import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:firebase_database/firebase_database.dart';


class SQLHelper {
  static Future<void> createTables(sql.Database database) async {

    final DatabaseReference fireBaseDB = FirebaseDatabase.instance.reference();

    await database.execute("""CREATE TABLE pages(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        position TEXT,
        date TEXT,
        people TEXT,
        budget TEXT,
        remark TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'post.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createItem(String title, String position, String date, String people, String budget, String remark) async {
    final db = await SQLHelper.db();

    final data = {'title': title, 'position': position, 'date': date, 'people': people, 'budget': budget, 'remark': remark};
    final id = await db.insert('pages', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('pages', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('pages', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(
      int id, String title, String position, String date, String people, String budget, String remark) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title,
      'position': position,
      'date': date,
      'people': people,
      'budget': budget,
      'remark': remark,
      'createdAt': DateTime.now().toString()
    };

    final result =
    await db.update('pages', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("pages", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}