import 'package:flutter/material.dart';
import 'dart:async';

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
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: Hero(
          tag: 'logo',
          child: Image.asset(
            'images/logo.png',
            width: 95.0,
            height: 95.0,
          ),
        ),
      ),
    );
  }
}
