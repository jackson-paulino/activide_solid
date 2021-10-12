import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/mvvm/model/task_model.dart';
import 'package:testapp/repository/repository_interfaces.dart';

abstract class TaskRepository
    implements
        TaskGetInterface,
        TaskRepositoryInterface,
        TaskRemoveInterface,
        TaskUpdateInterface {}

class TaskSharedPrefferencesRepository implements TaskRepository {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void add(List<TaskModel> listTask) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setStringList(
        'listTask', listTask.map((e) => jsonEncode(e.toJson())).toList());
  }

  @override
  void update(List<TaskModel> listTask) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setStringList(
        'listTask', listTask.map((e) => e.toJson().toString()).toList());
  }

  @override
  void remove(TaskModel task) async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove('listTask');
  }

  @override
  Future<List<TaskModel>?> getListTasks() async {
    final SharedPreferences prefs = await _prefs;
    var listPrefs = prefs.getStringList('listTask') ?? [];
    var list = listPrefs
        .map<TaskModel>((e) => TaskModel.fromJson(jsonDecode(e)))
        .toList();

    return list;
  }
}

class TaskSecureStorageRepository implements TaskRepository {
  final _secureStorage = const FlutterSecureStorage();

  @override
  void add(List<TaskModel> listTask) {
    var list = listTask.map((e) => jsonEncode(e.toJson())).toList().toString();
    print(list);
    _secureStorage.write(key: 'taskList', value: list);
  }

  @override
  void update(List<TaskModel> listTask) {
    var list = listTask.map((e) => e.toJson().toString()).toString();
    print(list);
    _secureStorage.write(key: 'taskList', value: list);
  }

  @override
  void remove(TaskModel task) {
    _secureStorage.delete(key: 'taskList');
  }

  @override
  Future<List<TaskModel>?> getListTasks() async {
    final secure = await _secureStorage.read(key: 'taskList');
    var listSecure = jsonDecode(secure.toString());

    var list = listSecure.map<TaskModel>((e) => TaskModel.fromJson(e)).toList();

    return list;
  }
}
