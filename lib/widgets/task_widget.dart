import 'package:flutter/material.dart';
import 'package:xtimer/model/task_model.dart';

class TaskWidget extends StatelessWidget{
  final Task task;
  TaskWidget({Key key, this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3.0),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
          style: BorderStyle.solid
        )
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(8.0),
            width: 30.0, height: 30.0,
            decoration: BoxDecoration(
                color: task.color,
                borderRadius: BorderRadius.circular(40.0)
            ),
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