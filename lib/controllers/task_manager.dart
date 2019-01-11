import 'package:flutter/material.dart';

import 'package:xtimer/model/task_model.dart';

class TaskManager {
  static DateTime now() => DateTime.now();

  /// A set of tasks
  static List<Task> tasksList = [
    Task(Colors.purple, 'Pratice Flutter', 1),
    Task(Colors.amber, 'Read about Bitcoin', 3),
    Task(Colors.deepOrange, 'Learn English', 2),
    Task(Colors.teal, 'Meditation', 5),
  ];

  static addNewTask(Task task) => tasksList.add(task);
}
