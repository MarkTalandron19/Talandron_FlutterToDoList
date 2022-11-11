import 'package:flutter/material.dart';
import 'ToDo.dart';

class ToDoItem extends StatefulWidget {
  const ToDoItem({super.key, required this.todo});

  final ToDo todo;

  TextStyle? getStyle() {
    if (todo.getFinish() == false) return null;

    return const TextStyle(
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.todo.setFinish();
        });
      },
      child: Text(
        widget.todo.getItem(),
        style: widget.getStyle(),
      ),
    );
  }
}
