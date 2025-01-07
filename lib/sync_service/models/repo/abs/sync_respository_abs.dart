abstract class SyncRepositoryAbs {
  Future<void> addNewTasksToRemote();
  Future<void> updateLocalWithRemoteChanges();
  Future<void> updateRemoteWithLocalChanges();
  Future<void> syncDeletedTasks();
}
