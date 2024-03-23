// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:juno/data/databasehabits.dart';
import 'package:juno/data/theme.dart';
import 'package:juno/models/my_drawer.dart';
import 'package:juno/pages/habit_page.dart';
import 'package:juno/pages/home_page.dart';
import 'package:juno/pages/people_page.dart';
import 'package:juno/pages/task_edit_page.dart';
import 'package:juno/pages/task_page.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var path = (await getApplicationDocumentsDirectory()).path;
  Hive.init(path);
  final _habits = await Hive.openBox("habits");
  WakelockPlus.enable();
  runApp(MaterialApp(home: MyApp()));
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
    TaskPage(),
    TaskEditPage(),
  ];
  final List<String> _pageAppBar = [
    "Expenses",
    "Expenses",
    "Habits",
    "Task",
    "Task Edit"
  ];
  var _pageSelected = 2;
  final _myTheme = MyThemes().lightTheme;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HabitsDatabase(),
      child: MaterialApp(
        title: 'Juno',
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(useMaterial3: true, primarySwatch: Colors.grey),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: _myTheme.background,
          appBar: AppBar(
            title: Text(_pageAppBar[_pageSelected]),
            backgroundColor: _myTheme.backgroundAccent,
            elevation: 8,
          ),
          body: _pages[_pageSelected],
          // body: MyButton(onTap: () {}, child: Icon(Icons.abc)),
          // body: TimePickerDemo(),
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
