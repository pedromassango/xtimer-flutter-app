import 'package:flutter/material.dart';
import 'package:xtimer/controllers/Database.dart';
import 'package:xtimer/controllers/task_manager.dart';
import 'package:xtimer/pages/home_page/home_bloc.dart';
import 'package:xtimer/pages/new_task_page.dart';
import 'package:xtimer/pages/splash_page.dart';
import 'package:xtimer/pages/home_page/home_page.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDelegate extends BlocDelegate{
  @override
  void onTransition(Transition transition) {
    print(transition);
  }
}

void main(){
  BlocSupervisor().delegate = MyDelegate();

  DatabaseProvider dbProvider = DatabaseProvider.db;
  TaskManager taskManager = TaskManager(dbProvider: dbProvider);
  HomeBloc homeBloc = HomeBloc(taskManager: taskManager);

  runApp(new MyApp(
    homeBloc: homeBloc,
  ));
}

class MyApp extends StatefulWidget {
  final HomeBloc homeBloc;
  const MyApp({Key key, this.homeBloc}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void dispose() {
    widget.homeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return BlocProvider<HomeBloc>(
      bloc: widget.homeBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => HomePage(),
          '/new': (context) => NewTaskPage(),
        },
      ),
    );
  }
}