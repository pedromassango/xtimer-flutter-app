import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:xtimer/model/task_model.dart';

abstract class HomeEvent extends Equatable{
  HomeEvent([List tmp = const []]): super(tmp);
}

class HomeEventLoad extends HomeEvent{
  @override
  String toString() => 'HomeEventLoad';
}

class HomeEventAdd extends HomeEvent{
  final Task task;
  HomeEventAdd({ @required this.task}): super([task]);

  @override
  String toString() => 'HomeEventAdd';
}