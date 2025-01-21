import 'dart:convert';
import 'dart:developer';

import 'package:aiplus_to_do/todo/domain/model/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class SharedPrefLocalDb {
  final SharedPreferences sharedPrefInstance;

  SharedPrefLocalDb({required this.sharedPrefInstance});

  Future<void> addTask(
      {required String taskTitle, required bool isDone}) async {
    final TaskModel newTaskModel = TaskModel.newTaskModel(isDone, taskTitle);
    await sharedPrefInstance.setString(
        newTaskModel.uuid, jsonEncode(newTaskModel.toJson()));
  }

  Future<void> editTaskStatus(
      {required String uuid, required bool isDone}) async {
    final data = sharedPrefInstance.getString(uuid);
    if (data != null) {
      final task = TaskModel.fromJson(jsonDecode(data));
      await sharedPrefInstance.remove(task.uuid);
      await sharedPrefInstance.setString(
          task.uuid, jsonEncode(task.copyWith(isDone: isDone).toJson()));
    }
  }

  Future<TaskModel?> getTaskByUUID(String uuid) async {
    final data = sharedPrefInstance.getString(uuid);
    if (data != null) {
      return TaskModel.fromJson(jsonDecode(data));
    }
    return null;
  }

  Future<List<TaskModel>?> getTasks() async {
    final keys = sharedPrefInstance.getKeys();
    final tasks = <TaskModel>[];

    for (var key in keys) {
      final data = sharedPrefInstance.getString(key);
      if (data != null) {
        try {
          final task = TaskModel.fromJson(jsonDecode(data));
          tasks.add(task);
        } catch (e) {
          log('Error decoding task with key $key: $e');
        }
      }
    }
    return tasks;
  }

  Future<void> deleteTask(String uuid) async {
    await sharedPrefInstance.remove(uuid);
  }

  Future<void> clearAllTasks() async {
    final keys = sharedPrefInstance.getKeys();
    for (var key in keys) {
      await sharedPrefInstance.remove(key);
    }
  }
}
