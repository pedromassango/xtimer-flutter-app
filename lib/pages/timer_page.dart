import 'package:flutter/material.dart';
import 'package:xtimer/model/task_model.dart';
import 'package:xtimer/widgets/rounded_button_widget.dart';
import 'dart:async';

class TimerPage extends StatefulWidget{
  final Task task;

  TimerPage({Key key, @required this.task}): super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage>{
  Task getTask() => widget.task;

  /// Store button state
  bool started = false;
  /// Store the time
  int time;
  /// Button text
  String buttonText = 'Start';
  /// The task timer
  Timer timer;

  @override
  void initState() {
    super.initState();
    _restartCountDown();
  }


  void _restartCountDown(){
    setState(() {
      started = false;
      time = getTask().date.minute;
      buttonText = 'start';
    });
  }

  void _playPause(){
    setState(() {
      if(started){
        buttonText = 'resume';
      }else{
        buttonText = 'start';
      }

      started = !started;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getTask().color,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: getTask().color,
        leading: IconButton(
            icon: Icon(Icons.navigate_before,size: 42.0,),
            onPressed: (){
              Navigator.of(context).pop();
            }
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.sync, size: 30.0,),
            onPressed: _restartCountDown,
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 80.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text( time.toString()+'m',
                style: TextStyle(
                    fontSize: 50.0,
                    color: Colors.white70
                ),
              ),
              Text('Left on this Task',
              style: TextStyle(
                color: Colors.white70
              ),
              ),

              Container(
                margin: EdgeInsets.only(top: 160.0),
                child: GestureDetector(
                  child: RoundedButton( text: buttonText,),
                  onTap: (){
                    setState(() {
                      _playPause();
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}