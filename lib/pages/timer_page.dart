import 'package:flutter/material.dart';
import 'package:xtimer/model/task_model.dart';
import 'package:xtimer/widgets/rounded_button_widget.dart';
import 'dart:async';

class TimerPage extends StatefulWidget {
  final Task task;

  TimerPage({Key key, @required this.task}) : super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> with SingleTickerProviderStateMixin {
  Task getTask() => widget.task;

  /// Store button state
  bool started = false;

  /// Store the time
  /// You will pass the minutes.
  int time;

  /// Button text
  String buttonText = 'Start';

  // Status Text
  String statusText = "Left on this Task";
  /// The task timer
  int timer;
  Animation<double> heightSize;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,

    );

    heightSize = new Tween(begin: 800.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _restartCountDown();
  }
  startTimer() async{
    print("Timer started..");
    new Timer.periodic(new Duration(seconds: 60), (timer){
      setState(() {
        time--;
      }
      );
      if(time==0){
        timer.cancel();
        statusText = "Times up";
      }
    });

  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  void _restartCountDown() {
    setState(() {
      started = false;
      time = getTask().date;
      buttonText = 'start';
    });
  }

  void _playPause() {
    setState(() {
      if (started) {
        buttonText = 'resume';
        _controller.forward();
      } else {
        buttonText = 'start';
        _controller.reset();
      }
      started = !started;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black54,
      body: Stack(

        children: <Widget>[
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child){
              return Container(
                height: heightSize.value,
                width: double.infinity,
                color: getTask().color,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0, left: 4.0, right: 4.0),
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.navigate_before,
                      size: 40.0,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.sync,
                    size: 32.0,
                    color: Colors.white70,
                  ),
                  onPressed: _restartCountDown,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 120.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        time.toString(),
                        style: TextStyle(fontSize: 54.0, color: Colors.white),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          'm',
                          style: TextStyle(fontSize: 25.0, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    statusText,
                    style: TextStyle(color: Colors.white70),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 220.0),
                    child: GestureDetector(
                      child: RoundedButton(
                        text: buttonText,
                      ),
                      onTap: () {
                        /*
                        setState(() {
                          _playPause();
                        });*/
                        startTimer();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
