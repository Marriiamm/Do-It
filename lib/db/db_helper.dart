import 'package:flutter/material.dart';
import 'package:todo/models/task_model.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = 'tasks';

  //only in the first time
  static Future<void> initDb() async {
    if (_db != null) {
      debugPrint('db is not null');
      return;
    } 
      try {
        // ignore: prefer_interpolation_to_compose_strings
        String path = await getDatabasesPath() + 'tasks.db';
        debugPrint('in database path');
        _db = await openDatabase(path, version: _version,
          onCreate: (Database db, int version) async {
          debugPrint('Create anew one');
          await db.execute(
            'CREATE TABLE $_tableName ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT, '
            'title STRING, note TEXT, date STRING, '
            'startTime STRING, endTime STRING, '
            'remind INTEGER, repeat STRING, '
            'color INTEGER, '
            'isCompleted INTEGER)',
          );
        debugPrint('Createeeeeeeeee anew one');
        });
      } catch (e) {
        print(e);
      }
    
  }

  static Future<int> insertFun(TaskModel? task) async {
    print("insert");
    return await _db!.insert(_tableName, task!.toJson());
  }

  static Future<int> delete(TaskModel task) async {
    print("delete");
    return await _db!.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }

  static Future<int> deleteAll() async {
    print("delete all");
    return await _db!.delete(_tableName);
  }

  static Future<List<Map<String, dynamic>>> queryy() async {
    print("queryy");
    return await _db!.query(_tableName);
  }

  static Future<int> updateFun(int id) async {
    print("update");
    return await _db!.rawUpdate('''
      UPDATE tasks
      SET isCompleted =?
      WHERE id = ?
    ''', [1, id]);
  }
}
