import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:xtimer/model/task_model.dart';

abstract class HomeEvent extends Equatable{
  HomeEvent([List tmp = const []]): super(tmp);
}

class LoadTasksEvent extends HomeEvent{
  @override
  String toString() => 'LoadTasksEvent';
}

class SaveTaskEvent extends HomeEvent{
  final Task task;
  SaveTaskEvent({ @required this.task}): super([task]);

  @override
  String toString() => 'SaveTaskEvent';
}

class DeleteTaskEvent extends HomeEvent{
  final Task task;
  DeleteTaskEvent({ @required this.task}): super([task]);

  @override
  String toString() => 'DeleteTaskEvent';
}