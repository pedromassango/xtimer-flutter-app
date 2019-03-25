import 'dart:async';

import 'package:xtimer/controllers/Database.dart';
import 'package:xtimer/model/task_model.dart';

class TaskManager {

  final DatabaseProvider dbProvider;

  TaskManager({ this.dbProvider});

  Future<List<Task>> _tasksData;

  Future<List<Task>> get tasksData => _tasksData;

  Future<void> addNewTask(Task task) async {
    return dbProvider.insert(task);
  }

  Future<List<Task>> loadAllTasks() async {
    return _tasksData = dbProvider.getAll();
  }
}
