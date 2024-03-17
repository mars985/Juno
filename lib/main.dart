// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:juno/data/databasehabits.dart';
import 'package:juno/models/habit_widgets.dart';
import 'package:juno/models/my_drawer.dart';
import 'package:juno/pages/habit_page.dart';
import 'package:juno/pages/home_page.dart';
import 'package:juno/pages/people_page.dart';
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
  ];
  final List<String> _pageAppBar = [
    "Expenses",
    "Expenses",
    "Habits",
    "Task",
  ];
  var _pageSelected = 3;

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
          // body: MyButton(onTap: () {}, child: Icon(Icons.abc)),
          // body: MyContainerWidget(),
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



class MyContainerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Handle tap event here, for example, you can print something
          print('Container tapped!');
          // You can also add more actions here if needed.
        },
        child: Container(
          width: 400,
          height: 400,
          color: Colors.blue,
          child: Center(
            child: Text(
              'Tap me!',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}