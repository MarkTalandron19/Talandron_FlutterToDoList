import 'package:flutter/material.dart';
import 'ToDoList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const ToDoList(),
    );
  }
}
