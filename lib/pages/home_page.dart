import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:juno/data/database.dart';
import 'package:juno/data/theme.dart';

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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  var _textController = TextEditingController();
  Themes theme = Themes();
  var themePicked = 1;
  getColor(paletteName) {
    // return theme.colorPalette[themePicked][index];
    return Color(theme.colors[themePicked][paletteName]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColor("background"),
      appBar: AppBar(
        title: Text(
          "Expenses",
          style: TextStyle(color: getColor("text_dark")),
        ),
        backgroundColor: getColor("background"),
      ),
      body: Text(
        "hello",
        style: TextStyle(color: getColor("text_dark")),
      ),
      bottomNavigationBar: Container(
        color: getColor("primary"),
        child: GNav(
          // padding: EdgeInsets.all(10),
          iconSize: 24,
          tabBackgroundColor: getColor("accent"),
          tabBorderRadius: 20,
          // padding: EdgeInsets.all(20),
          tabs: [
            GButton(
                iconActiveColor: getColor("secondary"),
                icon: Icons.home,
                text: "H O M E"),
          ],
        ),
      ),
    );
  }
}
