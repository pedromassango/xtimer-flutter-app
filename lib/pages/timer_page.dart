import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:xtimer/model/task_model.dart';
import 'package:xtimer/widgets/rounded_button_widget.dart';
import 'dart:async';

import 'package:xtimer/widgets/wave_animation.dart';

class TimerPage extends StatefulWidget {
  final Task task;

  TimerPage({Key key, @required this.task}) : super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage>
    with SingleTickerProviderStateMixin {
  Timer timer;

  Task get task => widget.task;

  /// Store the time
  /// You will pass the minutes.
  String timeText = '';
  String buttonText = 'Start';
  String statusText = "Left on this Task";

  Stopwatch stopwatch = Stopwatch();
  static const delay = Duration(microseconds: 1);

  /// for animation
  var begin = 0.0;
  Animation<double> heightSize;
  AnimationController _controller;

  /// Called each time the time is ticking
  void updateClock(){
    print('--updateClock()--');

    // if time is up, stop the timer
    if(stopwatch.elapsed.inMinutes == task.minutes){
      if(Navigator.canPop(context)){
        print('--finished Timer Page--');
        Navigator.pop(context);
      }
      return;
    }

    var currentMinute = stopwatch.elapsed.inMinutes;

    setState(() {
      timeText = '${currentMinute.toString().padLeft(2,"0")}:${((stopwatch.elapsed.inSeconds%60)).toString().padLeft(2, '0')}';
    });

    if (stopwatch.isRunning) {
      setState(() {

        statusText = "${task.minutes-currentMinute} minutes left";
        buttonText = "Running";
      });
    }else if(stopwatch.elapsed.inSeconds == 0){
      setState(() {
        timeText = '${task.minutes}:00';
        statusText = "Left on this Task";
        buttonText = "Start";
      });
    }else{
      setState(() {
        statusText = 'Paused';
        buttonText = "Paused";
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(minutes: task.minutes),
      vsync: this,
    );

    _controller.addStatusListener((state){
      print('-----animation state: $state');
    });
    
    timer = Timer.periodic(delay, (Timer t) => updateClock());
  }

  @override
  void dispose() {
    _controller.dispose();
    stopwatch.stop();
    super.dispose();
  }

  void _restartCountDown() {
    begin = 0.0;
    _controller.reset();
    stopwatch.stop();
    stopwatch.reset();
  }


  @override
  Widget build(BuildContext context) {

    heightSize = new Tween(
        begin: begin,
        end: MediaQuery.of(context).size.height-65
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    Size size = new Size(
        MediaQuery.of(context).size.width,
        heightSize.value
    );

    return Scaffold(
      backgroundColor: Color(0xFF212121),
      body: Stack(
        children: <Widget>[
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return DemoBody(
                  size: size,
                  color: task.color
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32.0, left: 4.0, right: 4.0),
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
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(bottom: 100),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      timeText,
                      style: TextStyle(fontSize: 54.0, color: Colors.white),
                    ),
                    Text(
                      statusText,
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 32),
              child: GestureDetector(
                  child: RoundedButton(text: buttonText),
                  onTap: () {
                    if (stopwatch.isRunning) {
                      print('--Paused--');
                      stopwatch.stop();
                      _controller.stop(canceled: false);
                    } else {
                      print('--Running--');
                      begin = 50.0;
                      stopwatch.start();
                      _controller.forward();
                    }

                    updateClock();
                  }),
            ),
          )
        ],
      ),
    );
  }
}