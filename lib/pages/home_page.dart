import 'package:flutter/material.dart';
import 'package:juno/models/some_database.dart';
import 'package:juno/models/todotile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final textController = TextEditingController();

  String boxText = "hello";

  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              // context.Navigator.pop(context);
              // boxText = textController.text;
              // ValueNotifier(boxText = textController.text);
              setState(() {
                boxText = textController.text;
              });
            },
            child: const Text("Create"),
          ),
        ],
      ),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlueBox(boxText: boxText),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onSubmitted: (value) {
                setState(() {
                  boxText = value;
                });
              },
            ),
          ),
          ElevatedButton(
            child: Text("page 2"),
            onPressed: () {
              Navigator.pushNamed(context, '/secondpage');
            },
          ),
          ListView(
            children: [
              ToDoTile(),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.text_fields_rounded),
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
