import 'package:flutter/material.dart';

import 'package:xtimer/model/task_model.dart';

class TaskManager {
  static DateTime now() => DateTime.now();

  /// A set of tasks
  static List<Task> tasksList = [
    Task(Colors.purple, 'Pratice Flutter', now().minute),
    Task(Colors.amber, 'Read about Bitcoin', now().minute),
    Task(Colors.deepOrange, 'Learn English', now().minute),
    Task(Colors.teal, 'Meditation', now().minute),
  ];

  static addNewTask(Task task) => tasksList.add(task);
}
