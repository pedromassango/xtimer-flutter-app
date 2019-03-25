import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtimer/pages/home_page/home_bloc.dart';
import 'package:xtimer/pages/home_page/home_events.dart';
import 'package:xtimer/pages/home_page/home_state.dart';
import 'package:xtimer/widgets/task_widget.dart';
import 'package:xtimer/pages/timer_page.dart';
import 'package:xtimer/pages/new_task_page.dart';

import 'package:xtimer/model/task_model.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  final String title = 'Task Timer';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _homeBloc;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// When called start timer Screen
  void _startTimerPage(Task task) {
    Navigator.of(context, rootNavigator: true)
        .push( CupertinoPageRoute<bool>(
        fullscreenDialog: true,
        builder: (buildContext) => TimerPage(task: task)
    )
    );
  }

  void _openBottomSheet() async {
    Task newTask = await showModalBottomSheet(
        context: context,
        builder: (context){
      return Container(
        color: Color(0xFF737373),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)
                )
            ),
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: NewTaskPage(),
          ),
        ),
      );
    });

    if(newTask != null){
      _homeBloc.dispatch(HomeEventAdd(task: newTask));
    }
  }

  @override
  Widget build(BuildContext context) {
    _homeBloc = BlocProvider.of(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.title,
          style: TextStyle(
              color: Colors.black,
              fontSize: 32.0,
              fontWeight: FontWeight.bold
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
              size: 32.0,
            ),
            onPressed: _openBottomSheet,
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 24.0),
        child: BlocBuilder<HomeEvent, HomeState>(
            bloc: _homeBloc,
            builder: (BuildContext context, state) {
              if (state is HomeStateLoading) {
                return Center(child: CircularProgressIndicator(),);
              }

              if (state is HomeStateLoaded) {
                final tasks = state.tasks;

                if (tasks.length == 0) {
                  return Center(
                    child: Text('No Tasks!',
                      style: TextStyle(
                          fontSize: 24
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: tasks.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    var item = tasks.elementAt(index);
                    return GestureDetector(
                      child: TaskWidget(task: item),
                      onTap: () => _startTimerPage(item),
                    );
                  },
                );
              }
            }
        ),
      ),
    );
  }
}
