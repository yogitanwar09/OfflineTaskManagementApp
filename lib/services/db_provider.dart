// ignore_for_file: constant_identifier_names

import 'package:atomcto_assignment/models/task_list_data.dart';
import 'package:atomcto_assignment/models/task_list_model.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseProvider {
  static const String TABLE_NAME = 'tasks';
  static const String DB_NAME = 'atomcto.db';

  Future<sql.Database> db() async {
    return sql.openDatabase(
      DB_NAME,
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  //This function is using for creating table
  Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE $TABLE_NAME(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        dueDate TEXT,
        status TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  Future<int> createTask(TaskListData taskListData) async {
    final db = await this.db();
    final id = await db.insert(TABLE_NAME, taskListData.toJson(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Update Task by taskId
  Future<int> updateTask(TaskListData taskListData, taskId) async {
    final db = await this.db();
    final result = await db.update(TABLE_NAME, taskListData.toJson(),
        where: "id = ?", whereArgs: [taskId]);
    return result;
  }

  //This function is using when filter is applied
  Future<TaskListModel> getTaskListByStatus(String? status) async {
    final db = await this.db();
    List<Map<String, dynamic>> dbData = await db.query(TABLE_NAME,
        where: "status = ?", whereArgs: [status], orderBy: 'dueDate');
    return TaskListModel.fromJson(dbData);
  }

  //This function is using for fetching the list with OrderBy Clause, so in this condition Incomplete records will come first
  Future<TaskListModel> getTaskList() async {
    final db = await this.db();
    List<Map<String, dynamic>> dbData = await db.rawQuery(
        "SELECT * FROM $TABLE_NAME ORDER BY status = 'Incomplete' DESC, dueDate ASC");
    return TaskListModel.fromJson(dbData);
  }

  //This function is using for getting one task details
  Future<TaskListModel> getTaskById(int id) async {
    final db = await this.db();
    List<Map<String, dynamic>> dbData =
        await db.query(TABLE_NAME, where: "id = ?", whereArgs: [id], limit: 1);
    return TaskListModel.fromJson(dbData);
  }

  //This function is using for deleting a task
  Future<void> deleteTask(int id) async {
    final db = await this.db();
    try {
      await db.delete(TABLE_NAME, where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting task: $err");
    }
  }
}
