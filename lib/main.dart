import 'package:flutter/material.dart';

import 'mvvm/view/task_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-do MVVM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskView(title: 'Facily To-do List MVVM'),
    );
  }
}
