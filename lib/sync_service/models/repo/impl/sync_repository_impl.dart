import 'package:tasky/app/tasks/models/data/get_task_response_model.dart';
import 'package:tasky/app/tasks/models/data/post_task_response_model.dart';
import 'package:tasky/app/tasks/models/data/tasks_response_model.dart';
import 'package:tasky/local_db/sql_lite_database_helper.dart';
import 'package:tasky/local_db/task_response_model.dart';
import 'package:tasky/models/networking_response.dart';
import 'package:tasky/services/networking_service.dart';
import 'package:tasky/services/secure_storage.dart';
import 'package:tasky/utils/constants/app_urls.dart';

import '../../../../local_db/task_model.dart';
import '../abs/sync_respository_abs.dart';
import 'package:logging/logging.dart';

class SyncRepositoryImpl implements SyncRepositoryAbs {
  Logger log = Logger("SyncRepository🔄");

  @override
  Future<void> addNewTasksToRemote() async {
    try {
      Logger log = Logger("AddNewTasksToRemote🔄");
      log.info("Preparing to add new tasks to remote database🔁");

      log.info("Fetching new tasks from local database");
      final List<Task> newTasks =
          await SQLiteDatabaseHelper.instance.fetchUnsyncedTasks();
      log.info("Fetched ${newTasks.length} new tasks");
      log.info("Preparing to add ${newTasks.length} tasks to remote server");

      int count = 1;
      SecureStorage secureStorage = SecureStorage();
      String? token = await secureStorage.getToken();

      if (token == null) {
        log.severe("Login required‼️⚠️");
        log.severe("Aborting sync‼️");
        throw Exception("Login required");
      }

      Map<String, String> headers = {
        'accept': '*/*',
        'Authorization': ' Bearer $token',
        'Content-Type': ' application/json'
      };

      for (Task task in newTasks) {
        log.info("Adding task $count of ${newTasks.length}");

        DateTime lastModified = await secureStorage.getLastSynced();

        try {
          NetworkingResponse networkingResponse =
              await NetworkingService().makeHttpCall(
            headers: headers,
            method: NetworkingMethods.POST.name,
            url: AppUrls.BASE_URL + AppUrls.tasks.tasks,
            body: {
              "title": task.title,
              "description": task.description,
              "deadline": task.deadline.toIso8601String(),
              "isSynced": true,
              "lastUpdated": lastModified.toIso8601String()
            },
          );

          if (networkingResponse.statusCode == 200) {
            TaskResponseModel taskFromServer =
                TaskResponseModel.fromJson(networkingResponse.data);
            await SQLiteDatabaseHelper.instance.updateTask(task.copy(
                id: task.id,
                uuid: taskFromServer.id,
                isSynced: true,
                lastModified: lastModified));
          } else {
            log.severe("Failed to add task $count of ${newTasks.length}⚠️");
          }
        } catch (e) {
          log.severe("Failed to sync task $count of ${newTasks.length}⚠️");
          log.severe(e.toString());
          continue;
        }

        count++;
      }
      log.info("Adding tasks completed");
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> syncDeletedTasks() async {
    try {
      log.info("Preparing to synchronize deleted tasks🔁");

      log.info("Fetching deleted tasks from local database");
      final List<Task> deletedTasks =
          await SQLiteDatabaseHelper.instance.fetchDeletedTasks();
      log.info("Fetched ${deletedTasks.length} deleted tasks");
      log.info(
          "Preparing to sync ${deletedTasks.length} tasks with remote server");

      int count = 1;
      SecureStorage secureStorage = SecureStorage();
      String? token = await secureStorage.getToken();

      if (token == null) {
        log.severe("Login required‼️⚠️");
        throw Exception("Login required");
      }

      Map<String, String> headers = {
        'accept': '*/*',
        'Authorization': ' Bearer $token',
        'Content-Type': ' application/json'
      };

      for (Task task in deletedTasks) {
        log.info("Syncing task $count of ${deletedTasks.length}");

        try {
          NetworkingResponse networkingResponse =
              await NetworkingService().makeHttpCall(
            headers: headers,
            method: NetworkingMethods.DELETE.name,
            url: AppUrls.BASE_URL + AppUrls.tasks.tasks + "/${task.uuid}",
            body: {},
          );

          if (networkingResponse.statusCode == 200) {
            await SQLiteDatabaseHelper.instance.deleteTask(task.id);
          } else if (networkingResponse.statusCode == 404) {
            // Remote task not found, delete local task
            await SQLiteDatabaseHelper.instance.deleteTask(task.id);
          } else {
            log.severe("Failed to sync deleted task");
            throw Exception("Failed to sync task");
          }
        } catch (e) {
          log.severe("Failed to sync task $count of ${deletedTasks.length}");
          log.severe(e.toString());
          continue;
        }
      }
      log.info("Synced all tasks successfully✅");
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateLocalWithRemoteChanges() async {
    Logger log = Logger("UpdateLocalWithRemoteChanges");

    log.info("Preparing to update local databse with remote updates🔁");
    // Fetch updated tasks from local database
    log.info("Fetching updated tasks from remote database");

    try {
      SecureStorage secureStorage = SecureStorage();
      String? token = await secureStorage.getToken();
      DateTime? lastSynced = await secureStorage.getLastSynced();

      if (token == null) {
        log.severe("Login required‼️⚠️");
        throw Exception("Login required");
      }
      Map<String, String> headers = {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      };

      Map<String, String> queryParams = {
        'lastUpdated': lastSynced.toIso8601String(),
      };
      String queryString = Uri(queryParameters: queryParams).query;

      NetworkingResponse networkingResponse =
          await NetworkingService().makeHttpCall(
        headers: headers,
        method: NetworkingMethods.GET.name,
        url: AppUrls.BASE_URL + AppUrls.tasks.tasks + '?' + queryString,
        body: {},
      );
      if (networkingResponse.statusCode == 200) {
        log.info("Successfully fetched tasks from server");
        TasksResponseModel tasksResponseModel =
            TasksResponseModel.fromJson(networkingResponse.data);

        for (Content task in tasksResponseModel.content!) {
          // 1. Check if task exists in local database
          log.info("Checking if task exists in local database");
          Task? localTask =
              await SQLiteDatabaseHelper.instance.fetchTaskByUUID(task.id!);

          if (localTask == null) {
            // Task does not exist in local database
            // Insert task into local database
            log.info(
                "Task with id ${task.id} does not exist in local database");
            log.info("Inserting task with id ${task.id} into local database");
            Task newTask = Task(
              uuid: task.id,
              title: task.title!,
              description: task.description!,
              deadline: DateTime.parse(task.deadline!),
              isSynced: true,
              deleted: false,
              lastModified: DateTime.parse(task.lastUpdated!),
            );

            await SQLiteDatabaseHelper.instance.addTask(newTask);
          } else {
            // Task exists in local database
            log.info("Tasks with id ${task.id} exists in the database");

            // Check if local task is the latest
            log.info("Checking if local version is more recent");
            if (localTask.lastModified.isAfter(
              DateTime.parse(task.lastUpdated!),
            )) {
              log.warning(
                  "The local version of task ${task.id} is more recent");
              log.warning("Passing on updating the task");
            } else {
              // Update local database with latest data
              log.info("Remote changes are the most recent");
              log.info("Updating local task with remote data");
              try {
                await SQLiteDatabaseHelper.instance.updateTask(localTask.copy(
                  id: localTask.id,
                  uuid: task.id,
                  title: task.title,
                  description: task.description,
                  deadline: DateTime.parse(task.deadline!),
                  isSynced: true,
                  deleted: false,
                  lastModified: DateTime.parse(task.lastUpdated!),
                ));

                log.info("Updated task ${task.id} on local database");
              } catch (e) {
                log.severe(
                    "Failed to update task ${task.id} on local database with error: $e");
              }
            }
          }
        }
      }
    } catch (e) {
      log.severe("Failed to fetch tasks from server");
      log.severe("An error occured: ${e.toString()}");
      throw Exception("Failed to fetch tasks from server");
    }
  }

  @override
  Future<void> updateRemoteWithLocalChanges() async {
    try {
      DateTime lastModified = DateTime.now();

      Logger log = Logger("UpdateRemoteWithLocalChange🔄");
      log.info("Preparing to update remote with local changes");
      // Fetch updated tasks from local database
      log.info("Fetching updated tasks from local database");

      List<Task> updatedTasks =
          await SQLiteDatabaseHelper.instance.fetchUpdatedTasks();
      for (Task localUpdatedTask in updatedTasks) {
        log.info("Preparing to update task: ${localUpdatedTask.uuid}");

        // Get task record from remote server
        log.info("Fetching remote entry for task: ${localUpdatedTask.uuid}");
        SecureStorage secureStorage = SecureStorage();
        String? token = await secureStorage.getToken();

        if (token == null) {
          log.severe("Login required‼️⚠️");
          throw Exception("Login required");
        }
        Map<String, String> headers = {
          'accept': '*/*',
          'Authorization': 'Bearer $token',
        };

        try {
          NetworkingResponse networkingResponse =
              await NetworkingService().makeHttpCall(
            headers: headers,
            method: NetworkingMethods.GET.name,
            url: AppUrls.BASE_URL +
                AppUrls.tasks.tasks +
                "/" +
                localUpdatedTask.uuid!,
            body: {},
          );

          if (networkingResponse.statusCode == 404) {
            // Task does not exist on remote server
            // Create task on remote server
            log.info(
                "Task not found on remote server task: ${localUpdatedTask.toString()}");
          } else if (networkingResponse.statusCode == 200) {
            log.info("Task found on server");
            GetTaskResponseModel remoteTask =
                GetTaskResponseModel.fromJson(networkingResponse.data);
            log.info("Performing conflict resolution");
            // Check if local task is the latest
            if (localUpdatedTask.lastModified
                .isAfter(DateTime.parse(remoteTask.lastUpdated!))) {
              // Local task has the latest updates
              // Update remote task with local task data
              log.info("Local task has the latest updates");
              log.info("Updating remote task with local task data");
              NetworkingResponse updateTaskOnRemoteServerNetworkResponse =
                  await NetworkingService().makeHttpCall(
                headers: headers,
                method: NetworkingMethods.PUT.name,
                url: AppUrls.BASE_URL +
                    AppUrls.tasks.tasks +
                    "/" +
                    localUpdatedTask.uuid!,
                body: {
                  "title": localUpdatedTask.title,
                  "isSynced": true,
                  "description": localUpdatedTask.description,
                  "deadline": localUpdatedTask.deadline.toIso8601String(),
                  "lastUpdated": localUpdatedTask.lastModified.toIso8601String()
                },
              );
              if (updateTaskOnRemoteServerNetworkResponse.statusCode == 200) {
                log.info("Updated task on remote server");
              } else {
                log.info("Failed to update task on remote server");
                throw Exception("Failed to update task on remote server");
              }
            } else {
              // Remote task has the latest updates

              log.info("Remote task has the latest updates");
              log.info("Skipping update of remote task");
            }
          }
        } catch (e) {
          log.severe("Failed to fetch task: ${localUpdatedTask.uuid}");
          log.severe("An error occured : ${e.toString()}");
        }
      }
    } catch (e) {
      log.severe("Failed to fetch tasks from server with error: $e");
      throw Exception(e);
    }
  }
}
