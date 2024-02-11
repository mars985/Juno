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
  ExpensesDatabase db = ExpensesDatabase();

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

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // return GridView.builder(
    //   itemBuilder: (context, index) {
    //     return Placeholder();
    //   },
    //   itemCount: 3,
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    // );
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(
            top: 12,
          ),
          child: ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Person Person",
                  style: TextStyle(),
                ),
                Container(
                  // color: Colors.blueGrey[400],
                  // child: Expanded(
                  //   child: Text(
                  //     "blah blah blah blah blah blah blah blah",
                  //     overflow: TextOverflow.ellipsis,
                  //   ),
                  // ),
                ),
                if (isExpanded) Text("more text"),
              ],
            ),
            trailing: Text("\$1000"),
          ),
        );
      },
    );
  }
}


