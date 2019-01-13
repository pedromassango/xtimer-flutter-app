import 'package:flutter/material.dart';

class Task{
  final int id;
  final Color color;
  final String title;
  final int minutes;
  
  Task(this.id, this.color, this.title, this.minutes);

  factory Task.fromMap(Map<String, dynamic> json) => Task(
      json['id'],
      Color(json['color']),
      json['title'],
      json['minutes']
  );
}