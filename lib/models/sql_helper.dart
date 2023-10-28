import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database DB) async {
    await DB.execute("""Create TABLE items(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
     title TEXT,
      ans1 TEXT,
      ans2 TEXT,
      ans3 TEXT,
      ans4 TEXT,
      diff TEXT
    )""");
  }

  static Future<sql.Database> db() async {
    var databasesPath = await sql.getDatabasesPath();

    String path = (databasesPath.toString() + 'task.db');
    return sql.openDatabase(
      path,
      version: 1,
      onCreate: (sql.Database DB, int version) async {
        print("creating tables ...");
        await createTables(DB);
      },
    );
  }

  static Future<int> createItem(
    String title,
    String ans1,
    String ans2,
    String ans3,
    String ans4,
    String diff,
  ) async {
    final DB = await SQLHelper.db();

    final data = {
      'title': title,
      'ans1': ans1,
      'ans2': ans2,
      'ans3': ans3,
      'ans4': ans4,
      'diff': diff,
    };

    final id = await DB.insert(
      'items',
      data,
      conflictAlgorithm:
          sql.ConflictAlgorithm.replace, // this for prevent doublicating data
    );
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final DB = await SQLHelper.db();
    return DB.query(
      'items',
      orderBy: "diff",
    );
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final DB = await SQLHelper.db();
    return DB.query(
      'items',
      where: "id = ?",
      whereArgs: [id],
      orderBy: "diff",
    );
  }

  static Future<int> updateItem(
    int id,
    String title,
    String ans1,
    String ans2,
    String ans3,
    String ans4,
    String diff,
  ) async {
    final DB = await SQLHelper.db();

    final data = {
      'title': title,
      'ans1': ans1,
      'ans2': ans2,
      'ans3': ans3,
      'ans4': ans4,
      'diff': diff,
    };

    final result = DB.update(
      'items',
      data,
      where: "id = ?",
      whereArgs: [id],
    );
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final DB = await SQLHelper.db();
    try {
      DB.delete(
        'items',
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (err) {
      debugPrint("Something went wrong when deleting an item : $err ");
    }
  }
}
