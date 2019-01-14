import 'package:flutter/material.dart';
import 'package:sqflite/sql.dart';
import 'package:xtimer/controllers/Database.dart';
import 'package:xtimer/model/task_model.dart';

class TaskManager {

  DatabaseProvider dbProvider;

  /// A set of tasks
  static List<Task> tasksList = [
    Task(1, Colors.purple, 'Pratice Flutter', 1),
    Task(2, Colors.amber, 'Read about Bitcoin', 3),
    Task(3, Colors.deepOrange, 'Learn English', 2),
  ];

  addNewTask(Task task) {
    dbProvider = DatabaseProvider.db;
    dbProvider.insert(task);
  }

  Future<List<Task>> getAll() async {
    dbProvider = DatabaseProvider.db;
    return dbProvider.getAll();
  }
}
