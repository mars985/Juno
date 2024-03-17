// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:juno/models/habit_widgets.dart';
import 'package:juno/models/text_widgets.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          color: Colors.amberAccent,
          child: Column(
            children: [
              TaskInfoBar(),
              MyHeatMap(
                dataMap: {
                  DateTime(2024, 03, 01): 1,
                  DateTime(2024, 03, 02): 2,
                  DateTime(2024, 03, 03): 3,
                  DateTime(2024, 03, 04): 4,
                  DateTime(2024, 03, 05): 5,
                  DateTime(2024, 03, 17): 3,
                },
              ),
              TaskInfoBar2(),
              TaskInfoBar3(),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskInfoBar extends StatelessWidget {
  const TaskInfoBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                IconContainer(
                  icon: Icon(Icons.monitor_heart_rounded),
                  onTap: () {},
                ),
                SizedBox(
                  width: 8,
                ),
                Heading(text: "text"),
              ],
            ),
          ),
          Subtitle(text: "text"),
        ],
      ),
    );
  }
}

class TaskInfoBar2 extends StatelessWidget {
  const TaskInfoBar2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Icon(Icons.circle_outlined),
            color: Colors.blueAccent,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              child: Text("Completed 7/7"),
              color: Colors.blueAccent,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              child: Text("Daily"),
              color: Colors.blueAccent,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              child: Text("Total 10"),
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}

class TaskInfoBar3 extends StatelessWidget {
  const TaskInfoBar3({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.calendar_month_rounded),
        SizedBox(width: 20),
        Icon(Icons.edit_rounded),
        SizedBox(width: 20),
        Icon(Icons.delete_rounded),
        SizedBox(width: 20),
        Icon(Icons.share_rounded),
      ],
    );
  }
}
