import 'package:flutter/material.dart';
import 'package:xtimer/pages/new_task_page.dart';
import 'package:xtimer/pages/splash_page.dart';
import 'package:xtimer/pages/home_page.dart';
import 'package:xtimer/pages/timer_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => HomePage(),
        //'/timer': (BuildContext context) => TimerPage()
        '/new': (context) => NewTaskPage(),
      },
    );
  }
}