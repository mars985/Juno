import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:juno/data/database.dart';
import 'package:juno/data/theme.dart';
import 'package:juno/models/navbar.dart';

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
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  var _textController = TextEditingController();

  var themePicked = 0;
  Themes theme = Themes();
  getColor(paletteName) {
    // return theme.colorPalette[themePicked][index];
    return Color(theme.colors[themePicked][paletteName]);
  }

  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // placeholder
        Text(
          "home",
          style: TextStyle(color: getColor("text_dark")),
        ),
        Container(
          child: Text("container"),
          color: Colors.amber[800],
          width: 100,
          height: 100,
        )
      ],
    );
    // return Placeholder();
  }
}
