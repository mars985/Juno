// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:juno/pages/home_page.dart';
import 'package:juno/pages/second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        '/homepage': (context) => HomePage(),
        '/secondpage': (context) => SecondPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var amount = <int>[];
  var name = <String>[];
  var timestamp = <String>[];
  var description = <String>[];
  var mode = <String>[];
  var pending = <bool>[];

  void _doNothing() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("App Bar!"),
        elevation: 0,
      ),

      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BoxButtonHome(),
          BoxButton2(),
        ],
      ),

      // body: Padding(
      //   padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: <Widget>[
      //       const Transaction(),
      //       const Text(
      //         '*********Text???*********',
      //       ),
      //       Text(
      //         'Text!!!',
      //         style: Theme.of(context).textTheme.headlineMedium,
      //       ),
      //     ],
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: _doNothing,
        tooltip: 'Add transaction',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BoxButton2 extends StatelessWidget {
  const BoxButton2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/secondpage');
      },
      child: Container(
        height: 500,
        width: 500,
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            "!!go to page 2!!",
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}

class BoxButtonHome extends StatelessWidget {
  const BoxButtonHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/homepage');
      },
      child: Container(
        height: 500,
        width: 500,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(20),
        child: Text("go to home page"),
      ),
    );
  }
}

class Transaction extends StatelessWidget {
  const Transaction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        DecoratedBox(decoration: BoxDecoration(color: Colors.amberAccent))
      ],
    );
  }
}
