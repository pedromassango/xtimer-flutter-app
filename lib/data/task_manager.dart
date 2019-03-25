import 'dart:async';

import 'package:xtimer/data/Database.dart';
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
}
