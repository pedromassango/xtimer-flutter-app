import 'package:flutter/material.dart';
import 'package:xtimer/model/task_model.dart';

class TaskWidget extends StatelessWidget{
  final Task task;
  TaskWidget({Key key, this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: Colors.black,
          width: 8.0,
          style: BorderStyle.solid
        )
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 50.0, height: 50.0,
            color: task.color,
          ),
          Column(
            children: <Widget>[
              Text(task.title),
              Text('Duration: ${task.date.day}')
            ],
          )
        ],
      ),
    );
  }
}