// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:juno/data/databasehabits.dart';
import 'package:juno/models/my_drawer.dart';
import 'package:juno/pages/habit_page.dart';
import 'package:juno/pages/home_page.dart';
import 'package:juno/pages/people_page.dart';
import 'package:provider/provider.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  Hive.init("C:/Users/Admin/Documents/");
  final _habits = await Hive.openBox("habits");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
  final _habits = Hive.box("habits");

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HabitsDatabase(),
      child: MaterialApp(
        title: 'Juno',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true, primarySwatch: Colors.grey),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.grey[400],
          appBar: AppBar(title: Text(_pageAppBar[_pageSelected])),
          body: _pages[_pageSelected],
          drawer: MyDrawer(
            onTap: (index) {
              setState(() {
                _pageSelected = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
