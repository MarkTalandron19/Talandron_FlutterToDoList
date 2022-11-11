import 'package:flutter/material.dart';
import 'ToDo.dart';
import 'ToDoItem.dart';

class ToDoList extends StatefulWidget {
  ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<ToDo> toDoList = <ToDo>[];
  final itemController = TextEditingController();
  final editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('To Do List'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: toDoList.map((ToDo todo) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ToDoItem(
                                todo: todo,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      displayEditInput(context, todo);
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        toDoList.remove(todo);
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                    ),
                                  ),
                                ],
                              ),
                            ]);
                      }).toList(),
                    )
                  ],
                ),
              ),  
              Row(
                children: <Widget>[
                  const SizedBox(width: 335),
                  FloatingActionButton(
                    onPressed: (() {
                      displayAddInput(context);
                    }),
                    child: const Icon(
                      Icons.add,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ));
  }

  Future<void> displayEmptyError(BuildContext context) async {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Textfield is empty."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              )
            ],
          );
        }));
  }

  Future<void> displayAddInput(BuildContext context) async {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Text("Add new to do item."),
            content: TextField(
              controller: itemController,
            ),
            actions: [
              TextButton(
                  onPressed: (() {
                    if (itemController.text.isNotEmpty) {
                      setState(() {
                        toDoList.add(
                            ToDo(item: itemController.text, finish: false));
                        itemController.clear();
                      });
                      itemController.clear();
                      Navigator.pop(context);
                    } else {
                      displayEmptyError(context);
                    }
                  }),
                  child: const Text("Ok")),
              TextButton(
                  onPressed: (() {
                    Navigator.pop(context);
                  }),
                  child: const Text(
                    "Cancel",
                  ))
            ],
          );
        }));
  }

  Future<void> displayEditInput(BuildContext context, ToDo todo) async {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Text("Input edit."),
            content: TextField(
              controller: editController,
            ),
            actions: [
              TextButton(
                  onPressed: (() {
                    if (editController.text.isNotEmpty) {
                      setState(() {
                        toDoList[toDoList.indexOf(todo)] =
                            ToDo(item: editController.text, finish: false);
                      });
                      editController.clear();
                      Navigator.pop(context);
                    } else {
                      displayEmptyError(context);
                    }
                  }),
                  child: const Text("Ok")),
              TextButton(
                  onPressed: (() {
                    Navigator.pop(context);
                  }),
                  child: const Text(
                    "Cancel",
                  ))
            ],
          );
        }));
  }
}
