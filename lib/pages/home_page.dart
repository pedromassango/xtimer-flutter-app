import 'package:flutter/material.dart';
import 'package:xtimer/widgets/task_widget.dart';
import 'package:xtimer/pages/timer_page.dart';
import 'package:flutter/services.dart';
import 'package:xtimer/model/task_model.dart';

class HomePage extends StatefulWidget {

  final String title = 'X - Timer';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  /// A set of tasks
  List<Task> tasksList = [
    Task(Colors.green, 'Study', DateTime.now()),
    Task(Colors.red, 'Workout', DateTime.now()),
    Task(Colors.purple, 'Pratice Flutter', DateTime.now()),
    Task(Colors.amber, 'Read about Bitcoin', DateTime.now()),
    Task(Colors.blue, 'Pratice Piano', DateTime.now()),
    Task(Colors.deepOrange, 'Learn English', DateTime.now()),
    Task(Colors.teal, 'Meditation', DateTime.now()),
    Task(Colors.deepPurple, 'Read about Bitcoin', DateTime.now()),
  ];

  @override
  void initState(){
    super.initState();
    // Set this screen as a fullscreen
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  /// When called, close this Screen
  void _closePage() {
    Navigator.of(context).pop();
  }

  /// When called start timer Screen
  void _startTimerPage(Task task){
    Navigator
        .of(context)
        .push(MaterialPageRoute(builder: (context) => TimerPage(task: task,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title:  new Text(widget.title, style:
        TextStyle(color: Colors.black,
              fontSize: 32.0,
              fontWeight: FontWeight.bold),
          ),
        //TODO: leading: Icon(Icons.menu, color: Colors.black,),
        actions: <Widget>[
          new IconButton(
            icon: Icon(Icons.add, color: Colors.black, size: 32.0,),
            onPressed: _closePage,
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 32.0),
        child: ListView.builder(
              itemCount: tasksList.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index){
                var item = tasksList.elementAt(index);
                return GestureDetector(
                  child: TaskWidget(task: item),
                  onTap: ()=> _startTimerPage(item),
                );
              },
        ),
      ),
    );
  }
}
