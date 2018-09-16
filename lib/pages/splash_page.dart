import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => new _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: Image.asset(
          'images/logo.png',
          width: 95.0,
          height: 95.0,
        ),
      ),
    );
  }
}
