import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:todo_app/task.dart';

class TaskDatabase {
  static TaskDatabase taskDatabase = TaskDatabase._();

  TaskDatabase._();

  Database? _database;

  Future<Database> get getDatabase async {
    if (_database != null) {
      return _database!;
    } else {
      var path = await getApplicationDocumentsDirectory();

      var db = sqlite3.open('${path.path}taskDb');

      var exist = File('${path.path}taskDb').existsSync();

      log(exist.toString());
      if (exist) {
        _database = db;
        return _database!;
      } else {
        db.execute('''
    CREATE TABLE taskDb (
      id INTEGER PRIMARY KEY,
      title TEXT NOT NULL,
      startDateTime INTEGER NOT NULL,
      endDateTime INTEGER NOT NULL
    );
  ''');

        _database = db;
        return _database!;
      }
    }
  }

  Future<bool> addTask(Task task) async {
    try {
      var db = await taskDatabase.getDatabase;

      var prep = db.prepare('''INSERT INTO taskDb VALUES (?,?,?,?)''');

      prep.execute([
        task.id,
        task.title,
        task.startDateTime?.millisecondsSinceEpoch,
        task.endDateTime?.millisecondsSinceEpoch,
      ]);

      return true;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<List<Task>> getAllTask() async {
    try {
      var db = await taskDatabase.getDatabase;

      List<Task> tasks = [];

      final ResultSet resultSet = db.select('SELECT * FROM taskDb');

      for (var element in resultSet) {
        Task newTask = Task.fromRow(element);
        tasks.add(newTask);
      }

      return tasks;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
