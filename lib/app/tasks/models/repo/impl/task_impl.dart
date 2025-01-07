import 'package:tasky/local_db/task_model.dart';
import 'package:tasky/app/tasks/models/repo/abs/task_repository.dart';

class TaskImpl implements TaskRepository {
  @override
  Future<void> createTask(Task task) async {
    // Get a reference to the database.
    //final db = await database;
  }

  @override
  Future<List<Task>> getTasks() {
    // TODO: implement getTasks
    throw UnimplementedError();
  }

  @override
  Future<void> updateTask(Task task) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
