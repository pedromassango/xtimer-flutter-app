import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => new _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  startTimer() async {
    // pause for a while then start home screen
    var duration = Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  void initState() {
    // Set this screen as a fullscreen
    SystemChrome.setEnabledSystemUIOverlays([]);

    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: Image.asset(
          'images/logox.png',
          width: 100.0,
          height: 100.0,
        ),
      ),
    );
  }
}
