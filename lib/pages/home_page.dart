import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:juno/data/database.dart';
import 'package:juno/models/todotile.dart';
import 'package:juno/util/dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final _myBox = Hive.box('myBox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    if (_myBox.get("TODOLISt") == "null") {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onCheckboxClicked(value, index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  var _textController = TextEditingController();

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          textController: _textController,
          onSave: () {
            setState(() {
              db.toDoList.add([_textController.text, false]);
            });
            Navigator.of(context).pop();
            _textController.clear();
            db.updateDataBase();
          },
          onCancel: () {
            Navigator.of(context).pop();
            _textController.clear();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),

      // display notes

      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (context) => onCheckboxClicked(context, index),
            deleteFunction: (context) {
              setState(() {
                db.toDoList.removeAt(index);
              });
              db.updateDataBase();
            },
          );
        },
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
      ),

      // create new note button

      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
