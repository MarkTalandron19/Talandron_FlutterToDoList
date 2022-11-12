import 'package:flutter/material.dart';
import 'ToDo.dart';
import 'ToDoItem.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<ToDo> toDoList = <ToDo>[];
  final itemController = TextEditingController();
  TextEditingController editController = TextEditingController();

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
                        return Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 200,
                                child: ToDoItem(
                                  todo: todo,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Checkbox(
                                      value: todo.getFinish(),
                                      onChanged: ((value) {
                                        setState(() {
                                          todo.setFinish();
                                        });
                                      })),
                                  const SizedBox(width: 20),
                                  IconButton(
                                    onPressed: () {
                                      displayEditInput(context, todo);
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.green,
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
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ]);
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  const SizedBox(width: 335),
                  FloatingActionButton(
                    backgroundColor: Colors.deepPurple[300],
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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Input here',
              ),
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
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.red[200],
                    ),
                  ))
            ],
          );
        }));
  }

  Future<void> displayEditInput(BuildContext context, ToDo todo) async {
    editController.text = todo.getItem();
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Text("Input edit."),
            content: TextField(
              controller: editController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
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
                  child: Text("Cancel",
                      style: TextStyle(
                        color: Colors.red[200],
                      )))
            ],
          );
        }));
  }
}
