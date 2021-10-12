import 'package:flutter/material.dart';
import 'package:testapp/mvvm/viewmodel/mode_view_model.dart';
import 'package:testapp/mvvm/viewmodel/task_view_model.dart';

class TaskView extends StatefulWidget {
  TaskView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final taskViewModel = TaskViewModel();
  final modeViewModel = ModeViewModel();

  final nameTextController = TextEditingController();
  final deadlineTextController = TextEditingController();

  void onEditTask() {
    taskViewModel.updateTask(
      modeViewModel.indexToEdit,
      nameTextController.text,
      deadlineTextController.text,
    );
    modeViewModel.setAddingMode();
  }

  @override
  void initState() {
    super.initState();
    taskViewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        width: size.width,
        height: 80,
        child: Column(
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () =>
                        taskViewModel.saveListShared(taskViewModel.tasks),
                    child: Text('SharedPreferences')),
                ElevatedButton(
                    onPressed: () =>
                        taskViewModel.saveListSecure(taskViewModel.tasks),
                    child: Text('Memoria SecureStorage')),
              ],
            ),
            Text('Opções de Salvar'),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        width: size.width * 1,
        height: size.height * 1,
        child: AnimatedBuilder(
          animation: taskViewModel,
          builder: (BuildContext context, Widget? child) {
            return AnimatedBuilder(
              animation: modeViewModel,
              builder: (BuildContext context, Widget? child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      width: size.width,
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffDCD5D5),
                            blurRadius: 15,
                            spreadRadius: 1,
                            offset: Offset(0, 0),
                          )
                        ],
                      ),
                      child: TextFormField(
                        controller: nameTextController,
                        decoration: InputDecoration(
                            hintText: "Nome da tarefa",
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 15),
                          width: size.width * 0.5,
                          height: size.height * 0.06,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffDCD5D5),
                                blurRadius: 15,
                                spreadRadius: 1,
                                offset: Offset(0, 0),
                              )
                            ],
                          ),
                          child: TextFormField(
                            controller: deadlineTextController,
                            decoration: InputDecoration(
                                hintText: "Data/Hora",
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: size.width * 0.25,
                          height: size.height * 0.07,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ElevatedButton(
                            onPressed: () => modeViewModel.isEditing
                                ? onEditTask()
                                : taskViewModel.addTask(nameTextController.text,
                                    deadlineTextController.text),
                            child: modeViewModel.isEditing
                                ? Text('Editar')
                                : Text('Adicionar'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Divider(
                      height: 4,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: taskViewModel.tasks.length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: Text(
                                      'Nome: ${taskViewModel.tasks[index].name.isEmpty ? 'Não informado' : taskViewModel.tasks[index].name}'),
                                  subtitle: Text(
                                      'Prazo: ${taskViewModel.tasks[index].deadline.isEmpty ? 'Não informado' : taskViewModel.tasks[index].deadline}'),
                                  trailing: Wrap(
                                    children: <Widget>[
                                      IconButton(
                                        onPressed: () {
                                          modeViewModel.setEditingMode(index);
                                          nameTextController.text =
                                              taskViewModel.tasks[index].name;
                                          deadlineTextController.text =
                                              taskViewModel
                                                  .tasks[index].deadline;
                                        },
                                        icon: Icon(Icons.edit),
                                        color: Colors.blue,
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            taskViewModel.removeTask(index),
                                        icon: Icon(Icons.delete),
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(),
                              ],
                            );
                          }),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
