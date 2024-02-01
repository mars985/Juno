import 'package:flutter/material.dart';
import 'package:juno/models/some_database.dart';
import 'package:juno/models/todotile.dart';
import 'package:juno/util/dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  late AnimationController _controller;
  final textController = TextEditingController();

  String boxText = "hello";

  List toDoList = [
    ["Do this", false],
    ["Do that", false],
    ["Do that again", false],
  ];

  onCheckboxClicked(value, index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
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
              toDoList.add([_textController.text, false]);
            });
            Navigator.of(context).pop();
            _textController.clear();
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
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            onChanged: (context) => onCheckboxClicked(context, index),
            deleteFunction: (context) {
              setState(() {
                toDoList.removeAt(index);
              });
            },
          );
        },
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BlueBox extends StatefulWidget {
  const BlueBox({
    super.key,
    required this.boxText,
  });

  final String boxText;

  @override
  State<BlueBox> createState() => _BlueBoxState();
}

class _BlueBoxState extends State<BlueBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blue,
      ),
      child: Center(
        child: Text(
          widget.boxText,
          style: TextStyle(
            fontSize: 30,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
