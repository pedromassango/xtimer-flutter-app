import 'package:xtimer/controllers/Database.dart';
import 'package:xtimer/model/task_model.dart';

class TaskManager {

  DatabaseProvider _dbProvider;
  Future<List<Task>> _tasksData;

  Future<List<Task>> get tasksData => _tasksData;

  addNewTask(Task task) {
    _dbProvider = DatabaseProvider.db;
    _dbProvider.insert(task);
  }

  loadAllTasks(){
    _dbProvider = DatabaseProvider.db;
    _tasksData = _dbProvider.getAll();
  }
}
