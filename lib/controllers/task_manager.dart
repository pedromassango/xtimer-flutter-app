import 'package:flutter/material.dart';
import 'package:xtimer/model/task_model.dart';

/// A new class to manage the tasks list

class TaskManager {
  static DateTime now() => DateTime.now();

  /// A set of tasks
  static List<Task> tasksList = [
    Task(Colors.green, 'Study', now().minute),
    Task(Colors.red, 'Workout', now().minute),
    Task(Colors.purple, 'Pratice Flutter', now().minute),
    Task(Colors.amber, 'Read about Bitcoin', now().minute),
    Task(Colors.blue, 'Pratice Piano', now().minute),
    Task(Colors.deepOrange, 'Learn English', now().minute),
    Task(Colors.teal, 'Meditation', now().minute),
    Task(Colors.deepPurple, 'Read about Bitcoin', now().minute),
  ];

  static List<Task> addNewTask(Task task) {
    tasksList.add(task);

    return tasksList;
  }
}
