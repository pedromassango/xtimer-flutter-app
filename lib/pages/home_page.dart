import 'package:flutter/material.dart';
import 'package:xtimer/widgets/task_widget.dart';
import 'package:xtimer/pages/timer_page.dart';
import 'package:xtimer/pages/new_task_page.dart';

import 'package:flutter/services.dart';
import 'package:xtimer/model/task_model.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  final String title = 'X - Timer';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  static DateTime now() => DateTime.now();
  
  /// A set of tasks
  List<Task> tasksList = [
    Task(Colors.green, 'Study', now().minute),
    Task(Colors.red, 'Workout', now().minute),
    Task(Colors.purple, 'Pratice Flutter', now().minute),
    Task(Colors.amber, 'Read about Bitcoin', now().minute),
    Task(Colors.blue, 'Pratice Piano', now().minute),
    Task(Colors.deepOrange, 'Learn English', now().minute),
    Task(Colors.teal, 'Meditation', now().minute),
    Task(Colors.deepPurple, 'Read about Bitcoin', now().minute),
  ];

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
    Navigator.of(context, rootNavigator: true).push(
        new CupertinoPageRoute<bool>(
            fullscreenDialog: true,
            builder: (buildContext) => TimerPage(task: task)));
    //.push(MaterialPageRoute(builder: (context) => TimerPage(task: task,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: new Text(
          widget.title,
          style: TextStyle(
              color: Colors.black, fontSize: 32.0, fontWeight: FontWeight.bold),
        ),
        //TODO: leading: Icon(Icons.menu, color: Colors.black,),
        actions: <Widget>[
          new IconButton(
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
