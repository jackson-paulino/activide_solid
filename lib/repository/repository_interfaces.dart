import 'package:testapp/mvvm/model/task_model.dart';

abstract class TaskRepositoryInterface {
  void add(List<TaskModel> listTask);
}

abstract class TaskRemoveInterface {
  void remove(TaskModel task);
}

abstract class TaskUpdateInterface {
  void update(List<TaskModel> listTask);
}

abstract class TaskGetInterface {
  Future<List<TaskModel>?> getListTasks();
}
