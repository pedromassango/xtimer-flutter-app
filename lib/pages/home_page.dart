import 'package:flutter/material.dart';
import 'package:xtimer/widgets/task_widget.dart';
import 'package:xtimer/pages/timer_page.dart';
import 'package:xtimer/pages/new_task_page.dart';

import 'package:flutter/services.dart';
import 'package:xtimer/model/task_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:xtimer/controllers/task_manager.dart';

class HomePage extends StatefulWidget {
  final String title = 'Task Timer';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Construction of task list
  List<Task> tasksList = TaskManager.tasksList;

  @override
  void initState() {
    super.initState();
    // Set this screen as a fullscreen
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  /// When called, start new task
  void _startNewTaskPage() {
    Navigator.of(context).pushNamed('/new');
  }

  /// When called start timer Screen
  void _startTimerPage(Task task) {
    Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute<bool>(
        fullscreenDialog: true,
        builder: (buildContext) => TimerPage(task: task)));
    //.push(MaterialPageRoute(builder: (context) => TimerPage(task: task,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.title,
          style: TextStyle(
              color: Colors.black, fontSize: 34.0, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
              size: 32.0,
            ),
            onPressed: _startNewTaskPage,
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 32.0),
        child: ListView.builder(
          itemCount: tasksList.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            var item = tasksList.elementAt(index);
            return GestureDetector(
              child: TaskWidget(task: item),
              onTap: () => _startTimerPage(item),
            );
          },
        ),
      ),
    );
  }
}
