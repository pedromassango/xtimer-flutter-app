import 'package:flutter/material.dart';
import 'package:xtimer/model/task_model.dart';

class TaskWidget extends StatelessWidget{
  final Task task;
  TaskWidget({Key key, this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 8.0,left: 8.0),
      padding: EdgeInsets.only(left: 8.0, top: 24.0, bottom: 24.0, right: 8.0),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.grey,
          width: 0.5,
        )
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0, right: 12.0),
            width: 15.0, height: 15.0,
            decoration: BoxDecoration(
                color: task.color,
                borderRadius: BorderRadius.circular(40.0)
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(task.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 19.0,
                fontWeight: FontWeight.bold
              ),
              ),
              Text('Duration: ${task.date}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0
              ),
              ),
            ],
          ),
          new Spacer(),
          new Icon(Icons.navigate_next, color: task.color,)
        ],
      ),
    );
  }
}