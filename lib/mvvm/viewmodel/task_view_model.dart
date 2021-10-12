import 'package:flutter/material.dart';
import 'package:testapp/mvvm/model/task_model.dart';
import 'package:testapp/repository/repository.dart';

class TaskViewModel extends ChangeNotifier {
  TaskSharedPrefferencesRepository _taskRepository =
      TaskSharedPrefferencesRepository();
  TaskSecureStorageRepository _taskSecureStorageRepository =
      TaskSecureStorageRepository();
  List<TaskModel> tasks = [];

  TaskViewModel();

  init() async {
    var list = await _taskSecureStorageRepository.getListTasks();
    tasks.addAll(list!);
    notifyListeners();
  }

  void addTask(String taskName, String deadline) {
    tasks.add(TaskModel(name: taskName, deadline: deadline));
    notifyListeners();
  }

  void removeTask(int index) {
    tasks.removeAt(index);
    notifyListeners();
  }

  void updateTask(int index, String newName, String newDeadline) {
    var item = tasks[index].copyWith(name: newName, deadline: newDeadline);
    tasks.removeAt(index);
    tasks.add(item);
    notifyListeners();
  }

  void saveListShared(List<TaskModel> list) {
    _taskRepository.add(list);
  }

  void saveListSecure(List<TaskModel> list) {
    _taskSecureStorageRepository.add(list);
  }
}
