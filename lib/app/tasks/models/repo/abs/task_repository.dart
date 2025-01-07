import '../../../../../local_db/task_model.dart';

abstract class TaskRepository {
  Future<void> createTask(Task task);
  Future<List<Task>> getTasks();
  Future<void> updateTask(Task task);
}
