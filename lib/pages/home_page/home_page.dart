import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtimer/pages/home_page/home_bloc.dart';
import 'package:xtimer/pages/home_page/home_events.dart';
import 'package:xtimer/pages/home_page/home_state.dart';
import 'package:xtimer/widgets/task_widget.dart';
import 'package:xtimer/pages/new_task_page.dart';

import 'package:xtimer/model/task_model.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  final String title = 'Task Timer';
  final HomeBloc homeBloc;
  const HomePage({Key key, @required this.homeBloc}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc get _homeBloc => widget.homeBloc;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openBottomSheet() async {
    Task newTask = await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: NewTaskPage(),
            ),
          );
        });

    if (newTask != null) {
      _homeBloc.dispatch(HomeEventAdd(task: newTask));
    }
  }

  @override
  void initState() {
    _homeBloc.dispatch(HomeEventLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.title,
          style: TextStyle(
              color: Colors.black, fontSize: 32.0, fontWeight: FontWeight.bold),
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
        child: BlocBuilder<HomeEvent, HomeState>(
            bloc: _homeBloc,
            builder: (BuildContext context, state) {
              if (state is HomeStateLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is HomeStateLoaded) {
                final List<Task> tasks = state.tasks;

                if (tasks.isEmpty) {
                  return Center(
                    child: Text(
                      'No Tasks!',
                      style: TextStyle(fontSize: 24),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: tasks.length,
                  padding: const EdgeInsets.only(top: 8),
                  itemBuilder: (BuildContext context, int index) {
                    final Task item = tasks.elementAt(index);
                    return TaskWidget(task: item);
                  },
                );
              } else {
                return SizedBox.shrink();
              }
            }),
      ),
    );
  }
}
