import 'package:async/async.dart';
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

class _TimerPageState extends State<TimerPage>
    with SingleTickerProviderStateMixin {
  Task getTask() => widget.task;

  /// Store the time
  /// You will pass the minutes.
  int time;
  String timeText = '00:00';
  String buttonText = 'Start';
  String statusText = "Left on this Task";

  Stopwatch stopwatch = Stopwatch();
  static const delay = Duration(seconds: 1);

  /// for animation
  Animation<double> heightSize;
  AnimationController _controller;

  /// Called each time the time is ticking
  void updateClock(){
    print('--updateClock()--');

    var currentMinute = stopwatch.elapsed.inMinutes;

    setState(() {
      timeText = '${currentMinute.toString().padLeft(2,"0")}:${((stopwatch.elapsed.inSeconds%60)).toString().padLeft(2, '0')}';
    });

    if (stopwatch.isRunning) {
      setState(() {

        statusText = "${getTask().minutes-currentMinute} minutes left";
        buttonText = "Running";
      });
    }else if(stopwatch.elapsed.inSeconds == 0){
      setState(() {
        timeText = '${getTask().minutes}:00';
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
      duration: Duration(minutes: getTask().minutes),
      vsync: this,
    );

    _controller.addStatusListener((state){
      print('-----animation state: $state');
    });
    
    Timer.periodic(delay, (Timer t) => updateClock());
  }

  @override
  void dispose() {
    _controller.dispose();
    stopwatch.stop();
    super.dispose();
  }

  void _restartCountDown() {
    _controller.reset();
    stopwatch.stop();
    stopwatch.reset();
  }

  @override
  Widget build(BuildContext context) {
    heightSize = new Tween(
        end: 0.0,
        begin: MediaQuery.of(context).size.height
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    return Scaffold(
      backgroundColor: Color(0xFF212121),
      body: Stack(
        children: <Widget>[
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
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
            margin: EdgeInsets.only(top: 130.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    timeText,
                    style: TextStyle(fontSize: 54.0, color: Colors.white),
                  ),
                  Text(
                    statusText,
                    style: TextStyle(color: Colors.white70),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 200.0),
                    child: GestureDetector(
                        child: RoundedButton(text: buttonText),
                        onTap: () {
                          if (stopwatch.isRunning) {
                            print('--Paused--');
                            stopwatch.stop();
                            _controller.stop(canceled: false);
                          } else {
                            print('--Running--');
                            stopwatch.start();
                            _controller.forward();
                          }

                          updateClock();
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
