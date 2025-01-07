import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasky/services/secure_storage.dart';

import 'task_model.dart';

class SQLiteDatabaseHelper {
  //instantiate an object that can be called anywhere in the app
  static final SQLiteDatabaseHelper instance = SQLiteDatabaseHelper._init();

  //table name stored in a string
  final String tasksTable = 'tasks';
  //database initialization
  SQLiteDatabaseHelper._init();

  //Database object
  static Database? _db;

  //Database creation
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb('taskyy.db');
    return _db;
  }

  //Method to create database
  Future<Database> initDb(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    print(dbPath);
    var openDb = await openDatabase(
      path,
      version: 2,
      onCreate: _createDb,
    );
    return openDb;
  }

  //method to create table
  Future _createDb(Database db, int version) async {
    print("Creating db");
    await db.execute('''
     CREATE TABLE tasks(
     id INTEGER PRIMARY KEY,
     uuid TEXT,
     title TEXT,
     description TEXT,
     deadline TEXT,
     lastModified TEXT,
     isSynced INTEGER,
     deleted INTEGER DEFAULT 0
      )''');
  }

  Future<Task> addTask(Task task) async {
    final db = await instance.db;

    final id = await db!.insert(tasksTable, task.toJson());
    return task.copy(id: id);
  }

  Future<List<Task>> fetchAllTasks() async {
    final db = await instance.db;
    List<Task> tasksList = [];
    try {
      final maps = await db!.query(SQLiteDatabaseHelper.instance.tasksTable);
      for (var item in maps) {
        tasksList.add(Task.fromJson(item));
      }
    } catch (e) {
      print(e.toString());
    }
    return tasksList;
  }

  Future<List<Task>> fetchDeletedTasks() async {
    final db = await instance.db;
    List<Task> tasksList = [];
    try {
      final maps = await db!.query(SQLiteDatabaseHelper.instance.tasksTable,
          where: 'deleted = ?', whereArgs: [1]);
      for (var item in maps) {
        tasksList.add(Task.fromJson(item));
      }
    } catch (e) {
      throw Exception(e);
    }
    return tasksList;
  }

  Future<Task?> fetchTaskByUUID(String uuid) async {
    final db = await instance.db;
    Task? task;
    try {
      final maps = await db!.query(SQLiteDatabaseHelper.instance.tasksTable,
          where: 'uuid = ?', whereArgs: [uuid]);
      task = Task.fromJson(maps.first);
    } catch (e) {
      // throw Exception(e);
    }
    return task;
  }

  Future<List<Task>> fetchUnsyncedTasks() async {
    final db = await instance.db;
    List<Task> tasksList = [];
    try {
      final maps = await db!.query(SQLiteDatabaseHelper.instance.tasksTable,
          where: 'isSynced = ?', whereArgs: [0]);
      for (var item in maps) {
        tasksList.add(Task.fromJson(item));
      }
    } catch (e) {
      throw Exception(e);
    }
    return tasksList;
  }

  Future<List<Task>> fetchUpdatedTasks() async {
    final db = await instance.db;
    SecureStorage secureStorage = SecureStorage();
    DateTime lastSynced = await secureStorage.getLastSynced();

    List<Task> tasksList = [];
    try {
      final maps = await db!.query(SQLiteDatabaseHelper.instance.tasksTable,
          where: 'lastModified > ?', whereArgs: [lastSynced.toIso8601String()]);
      for (var item in maps) {
        tasksList.add(Task.fromJson(item));
      }
    } catch (e) {
      throw Exception(e);
    }
    return tasksList;
  }

  Future<List<Task>> searchTask(String searchString) async {
    final db = await instance.db;
    List<Task> tasksList = [];
    try {
      final maps = await db!.query(SQLiteDatabaseHelper.instance.tasksTable,
          where: 'title LIKE ? OR description LIKE ? OR deadline LIKE ?',
          whereArgs: ['%$searchString%', '%$searchString%', '%$searchString%']);
      for (var item in maps) {
        tasksList.add(Task.fromJson(item));
      }
    } catch (e) {
      throw (e.toString());
    }
    return tasksList;
  }

  Future<void> updateTask(Task task) async {
    final db = await instance.db;

    await db!.update(
      tasksTable,
      task.toJson(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int? id) async {
    final Database? db = await instance.db;

    await db!.delete(
      tasksTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
