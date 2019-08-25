import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:xtimer/model/task_model.dart';

class DatabaseProvider{

  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();
  static Database _database;

  Future<Database> get database async{
    if(_database != null){
      return _database;
    }

    _database = await initDb();
    return _database;
  }

  initDb() async{

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'xtimeros.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE Task ('
              'id INTEGER PRIMARY KEY,'
              'color INTEGER,'
              'title TEXT,'
              'hours INTEGER,'
              'minutes INTEGER,'
              'seconds INTEGER'
              ')');
        }
    );
  }

  insert(Task task) async{
    print('Saving Task...');

    var db = await database;

    var table = await db.rawQuery('SELECT MAX(id)+1 as id FROM Task');
    var id = table.first['id'];

    var raw = db.rawInsert(
        'INSERT Into Task (id, color, title, hours, minutes, seconds) VALUES (?,?,?,?,?,?)',
        [id, task.color.value, task.title, task.hours, task.minutes, task.seconds]
    );

    print('Task saved :)');
    return raw;
  }

  Future<List<Task>> getAll() async {
    print('getting tasks...');

    var db = await database;
    var query = await db.query('Task');

    List<Task> tasks = query.isNotEmpty ?
        query.map((t) => Task.fromMap(t)).toList() : [ ];

    print('tasks in database: ${tasks.length}');
    return tasks;
  }

  Future<void> delete(int id) async {
    var db = await database;
     await db.rawDelete('DELETE FROM Task WHERE id = ?', [id]);
  }
}