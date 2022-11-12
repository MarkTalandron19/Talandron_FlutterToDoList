import 'package:flutter/material.dart';
import 'ToDo.dart';

class ToDoItem extends StatelessWidget {
  const ToDoItem({super.key, required this.todo});

  final ToDo todo;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        todo.getItem(),
      ),
    );
  }
}
