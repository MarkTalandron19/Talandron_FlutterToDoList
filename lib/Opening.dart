import 'package:flutter/material.dart';
import 'ToDo.dart';
import 'ToDoList.dart';

class Opening extends StatelessWidget {
  const Opening({super.key});

  @override
  Widget build(BuildContext context) {
    // Used as a temporary field so that the same list may be passed between screens
    List<ToDo> list = <ToDo>[];

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Image(image: AssetImage('assets/pencil.png')),
                ),
                Text(
                  'Things To Do',
                  style: TextStyle(
                    fontFamily: 'Signika Negative',
                    fontSize: 43,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 100,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ToDoList(toDoList: list)));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 183, 143, 253)),
                  child: const Text(
                    'Enter',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
