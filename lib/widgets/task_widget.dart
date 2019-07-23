import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xtimer/model/task_model.dart';
import 'package:xtimer/pages/timer_page.dart';

class TaskWidget extends StatelessWidget {
  TaskWidget({Key key, this.task});

  final Task task;
  final BorderRadius _borderRadius = BorderRadius.circular(8.0);

  /// When called start timer Screen
  void _startTimerPage(BuildContext context, Task task) {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute<bool>(
        fullscreenDialog: true,
        builder: (buildContext) => TimerPage(task: task),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: _borderRadius,
        border: Border.all(
          color: Colors.grey,
          width: 0.5,
        ),
      ),
      child: InkWell(
        onTap: () => _startTimerPage(context, task),
        borderRadius: _borderRadius,
        child: Padding(
          padding: EdgeInsets.only(left: 8, top: 26, bottom: 26, right: 8),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    left: 8.0, top: 8.0, bottom: 8.0, right: 12.0),
                width: 15.0,
                height: 15.0,
                decoration: BoxDecoration(
                    color: task.color,
                    borderRadius: BorderRadius.circular(40.0)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    task.title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 19.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Duration: ${task.minutes}',
                    style: TextStyle(color: Colors.black, fontSize: 14.0),
                  ),
                ],
              ),
              new Spacer(),
              new Icon(
                Icons.navigate_next,
                color: task.color,
              )
            ],
          ),
        ),
      ),
    );
  }
}
