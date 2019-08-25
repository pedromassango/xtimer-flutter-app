import 'dart:async';

import 'package:meta/meta.dart';
import 'package:xtimer/data/task_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:xtimer/pages/home_page/home_events.dart';
import 'package:xtimer/pages/home_page/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{
  final TaskManager taskManager;

  HomeBloc({ @required this.taskManager});

  @override
  HomeState get initialState => HomeStateLoading();

  @override
  Stream<HomeState> mapEventToState(
      HomeState currentState, HomeEvent event) async*{

    if(event is LoadTasksEvent){
      yield HomeStateLoading();

      final data = await taskManager.loadAllTasks();
      yield HomeStateLoaded(tasks: data);
    }

    if(event is SaveTaskEvent){
      yield HomeStateLoading();
      await taskManager.addNewTask(event.task);

      dispatch(LoadTasksEvent());
    }

    if(event is DeleteTaskEvent) {
      await taskManager.deleteTask(event.task);
    }

  }
}