import 'package:flutter/material.dart';
import 'ToDo.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key, required this.toDoList});
  final List<ToDo> toDoList;

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final itemController = TextEditingController();
  TextEditingController editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('To Do List'),
          centerTitle: true,
          leading: BackButton(
            onPressed: (() {
              Navigator.pop(context, widget.toDoList);
            }),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              widget.toDoList.isEmpty
                  ? displayEmpty(context)
                  : displayList(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const SizedBox(width: 0),
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

  Widget displayEmpty(BuildContext context) {
    return Expanded(
      child: Column(
      children: const [
        SizedBox(height: 150),
        Icon(
          Icons.emoji_emotions,
          color: Colors.yellow,
          size: 300,
        ),
        SizedBox(height: 20),
        Text("You have nothing to do!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.amber,
            )),
        SizedBox(height: 60),
      ],
    ));
  }

  Widget displayList(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          Column(
            children: widget.toDoList.map((ToDo todo) {
              return Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(
                        todo.getItem(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 134, 193, 242),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              widget.toDoList.remove(todo);
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
    );
  }

  Future<void> displayEmptyError(BuildContext context) async {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Text(
              "Error",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.red,
              ),
            ),
            content: const Text("Textfield is empty.",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )),
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
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: const Text(
              "Add new to do item.",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
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
                        widget.toDoList.add(
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
            title: const Text(
              "Input edit",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
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
                        widget.toDoList[widget.toDoList.indexOf(todo)] =
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
