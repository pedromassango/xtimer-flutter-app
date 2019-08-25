import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtimer/pages/bottom_sheet.dart';
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

  const HomePage({@required this.homeBloc}) : assert(homeBloc != null);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc get _homeBloc => widget.homeBloc;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openBottomSheet() async {
    final newTask = await showCustomModalBottomSheet<Task>(
        context: context,
        builder: (context) {
          return GestureDetector(
            onTap: () {},
            child: Container(
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
            ),
          );
        });

    if (newTask != null) {
      _homeBloc.dispatch(SaveTaskEvent(task: newTask));
    }
  }

  @override
  void initState() {
    _homeBloc.dispatch(LoadTasksEvent());
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
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 26, color: Colors.black),
        backgroundColor: Colors.white,
        onPressed: _openBottomSheet,
      ),
      body: Container(
        child: BlocBuilder<HomeEvent, HomeState>(
            bloc: _homeBloc,
            builder: (BuildContext context, state) {
              if (state is HomeStateLoading)
                return Center(child: CircularProgressIndicator());

              if (state is HomeStateLoaded) {
                final List<Task> tasks = state.tasks;

                if (tasks.isEmpty)
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('No Tasks',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text('Add a new Task and it\nwill show up here.',
                            textAlign: TextAlign.center)
                      ],
                    ),
                  );

                return ListView.builder(
                  itemCount: tasks.length,
                  padding: const EdgeInsets.only(top: 8),
                  itemBuilder: (BuildContext context, int index) {
                    final Task item = tasks.elementAt(index);
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Dismissible(
                        background: Container(color: Colors.red),
                        direction: DismissDirection.endToStart,
                        key: ObjectKey(item),
                          child: TaskWidget(task: item),
                        onDismissed: (direction) {
                          tasks.remove(item);
                          setState(() {});
                          _homeBloc.dispatch(DeleteTaskEvent(task: item));

                          Scaffold.of(context)
                              .showSnackBar(
                              SnackBar(content: Text("Task Deleted")));
                        },
                      ),
                    );
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
