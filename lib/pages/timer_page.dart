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
  String statusText = '';
  String buttonText = 'Start';

  Stopwatch stopwatch = Stopwatch();
  static const delay = Duration(microseconds: 1);

  /// for animation
  var begin = 0.0;
  Animation<double> heightSize;
  AnimationController _controller;

  /// Called each time the time is ticking
  void updateClock() {
    final duration = Duration(hours: task.hours, minutes: task.minutes, seconds: task.seconds);

    // if time is up, stop the timer
    if (stopwatch.elapsed.inMilliseconds == duration.inMilliseconds) {
        print('--finished Timer Page--');
        stopwatch.stop();
        stopwatch.reset();
        _controller.stop(canceled: false);
        setState(() {
          statusText = 'Finished';
          buttonText = "Restart";
        });
      return;
    }else {
      statusText = '';
    }

    final millisecondsRemaining = duration.inMilliseconds - stopwatch.elapsed.inMilliseconds;
    final hoursRemaining = ((millisecondsRemaining / (1000*60*60)) % 24).toInt();
    final minutesRemaining = ((millisecondsRemaining / (1000*60)) % 60).toInt();
    final secondsRemaining = ((millisecondsRemaining / 1000) % 60).toInt();

    setState(() {
      timeText =
          '${hoursRemaining.toString().padLeft(2, '0')}:'
              '${minutesRemaining.toString().padLeft(2, '0')}:'
              '${secondsRemaining.toString().padLeft(2, '0')}';
    });

    if (stopwatch.isRunning) {
      setState(() {
        buttonText = "Running";
      });
    } else if (stopwatch.elapsed.inSeconds == 0) {
      setState(() {
        timeText = '${task.hours.toString().padLeft(2, "0")}:'
            '${task.minutes.toString().padLeft(2, '0')}:'
            '${task.seconds.toString().padLeft(2, '0')}';
        buttonText = "Start";
      });
    } else {
      setState(() {
        buttonText = "Paused";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    final duration = Duration(
        days: 0,
        hours: task.hours,
        minutes: task.minutes,
        seconds: task.seconds
    );
    _controller = AnimationController(
      duration: duration,
      vsync: this,
    );

    timer = Timer.periodic(delay, (Timer t) => updateClock());
  }

  @override
  void dispose() {
    _controller.dispose();
    stopwatch.stop();
    timer.cancel();
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
    heightSize =
        new Tween(begin: begin, end: MediaQuery.of(context).size.height - 65)
            .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    Size size = Size(MediaQuery.of(context).size.width, heightSize.value);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return DemoBody(size: size, color: task.color);
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
              margin: EdgeInsets.only(bottom: 250),
              child: Center(
                child: Text(
                  task.title,
                  style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white70,
                      fontWeight: FontWeight.bold),
                ),
              ),
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
