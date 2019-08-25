import 'dart:async';

import 'package:xtimer/data/database.dart';
import 'package:xtimer/model/task_model.dart';

class TaskManager {

  final DatabaseProvider dbProvider;

  TaskManager({ this.dbProvider});

  Future<void> addNewTask(Task task) async {
    return dbProvider.insert(task);
  }

  Future<List<Task>> loadAllTasks() async {
    return dbProvider.getAll();
  }

  Future<void> deleteTask(Task task) async {
    return dbProvider.delete(task.id);
  }
}
