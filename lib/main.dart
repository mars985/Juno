// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:juno/data/database.dart';
import 'package:juno/data/theme.dart';
import 'package:juno/models/navdrawer.dart';
import 'package:juno/pages/habit_page.dart';
import 'package:juno/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:juno/pages/people_page.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('myBox');
  runApp(MyApp());
}
 

var _selectedIndex = 0;

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var themePicked = 0;
  Themes theme = Themes();

  getColor(paletteName) {
    // return theme.colorPalette[themePicked][index];
    return Color(theme.colors[themePicked][paletteName]);
  }

  final List<Widget> _pages = [
    HomePage(),
    PeoplePage(),
    HabitPage(),
  ];
  final List<String> _pageAppBar = [
    "Expenses",
    "Expenses",
    "Habits",
  ];
  var _pageSelected = 2;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          primarySwatch: Colors.grey),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text(
            _pageAppBar[_pageSelected],
            style: TextStyle(color: getColor("text_dark")),
          ),
          backgroundColor: getColor("background"),
        ),
        body: _pages[_pageSelected],
        drawer: myDrawer(
          onTap: (index) {
            setState(() {
              _pageSelected = index;
            });
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  final _myBox = Hive.box('myBox');
  ExpensesDatabase db = ExpensesDatabase();

  @override
  void initState() {
    // TODO: implement initState
    db.loadData();
  }
}
