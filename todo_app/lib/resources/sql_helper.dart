import 'package:sqflite/sqflite.dart';
import 'package:todo_app/model/task_model.dart';

class SQLHelper {
  static Future<Database> database = openDatabase(
    'todo.db',
    version: 1,
    onCreate: (db, version) {
      return db.execute(
        '''
          CREATE TABLE tasks(
            uid INTEGER PRIMARY KEY,
            title TEXT,
            description TEXT,
            category TEXT,
            date TEXT, 
            time TEXT, 
            time24 TEXT,
            timeOfCreation TEXT, 
            isDone INTEGER
          )
        ''',
      );
    },
  );

  // inset task to database
  Future<void> insertTask(TaskModel taskModel) async {
    final Database db = await database;

    await db.insert(
      'tasks',
      taskModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // get all tasks from database
  Future<List<TaskModel>> getTasks({int isDone = 0}) async {
    final Database db = await database;

    // get in ascending order by date and if date is same then by time24
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT * FROM tasks Where isDone = $isDone ORDER BY date ASC, time24 ASC',
    );

    // // get in ascending order by date and if date is same then by time24
    // final List<Map<String, dynamic>> maps = await db.rawQuery(
    //   'SELECT * FROM tasks ORDER BY date ASC, time24 ASC',
    // );

    List<TaskModel> data = List.generate(maps.length, (i) {
      return TaskModel(
        uid: maps[i]['uid'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        category: maps[i]['category'],
        date: maps[i]['date'],
        time: maps[i]['time'],
        time24: maps[i]['time24'],
        timeOfCreation: maps[i]['timeOfCreation'],
        isDone: maps[i]['isDone'] == 1 ? true : false,
      );
    });

    return data;
  }

  // update task in database
  Future<void> updateTask(int uid, TaskModel taskModel) async {
    final Database db = await database;

    taskModel.isDone = !taskModel.isDone;

    await db.update(
      'tasks',
      taskModel.toMap(),
      where: 'uid = ?',
      whereArgs: [uid],
    );
  }

  // delete task from database
  Future<void> deleteTask(int uid) async {
    final Database db = await database;

    await db.delete(
      'tasks',
      where: 'uid = ?',
      whereArgs: [uid],
    );
  }

  // delete all tasks from database
  Future<void> deleteAllTasks({int isDone = 0}) async {
    final Database db = await database;
    await db.delete('tasks', where: 'isDone = ?', whereArgs: [isDone]);
  }
}
