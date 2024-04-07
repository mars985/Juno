// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:juno/data/databasehabits.dart';

class TaskCreationDialog extends StatelessWidget {
  TaskCreationDialog({
    required this.habitsDatabase,
  });

  final HabitsDatabase habitsDatabase;
  final _controllerDescription = TextEditingController();
  final _controllerName = TextEditingController();

  void submitTask(BuildContext context) {
    habitsDatabase.pushNewTask(
        _controllerName.text, _controllerDescription.text);
    _controllerName.clear();
    _controllerDescription.clear();

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controllerName,
              autofocus: true,
              decoration:
                  InputDecoration(fillColor: Colors.grey[100], filled: true),
            ),
            TextField(
              controller: _controllerDescription,
              onEditingComplete: () => submitTask(context),
              decoration:
                  InputDecoration(fillColor: Colors.grey[100], filled: true),
            ),
            SizedBox(height: 10),
            IconButton(
              onPressed: () => submitTask(context),
              icon: Icon(Icons.done_rounded),
            ),
          ],
        ),
      ),
    );
  }
}



// class DoTaskDialog extends StatelessWidget {
//   DoTaskDialog({
//     super.key,
//     required this.habitsDatabase,
//     required this.index,
//   });

//   final TextEditingController _textcontroller = TextEditingController();
//   final HabitsDatabase habitsDatabase;
//   final int index;

//   void submitTask(BuildContext context) {
//     _textcontroller.clear();
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(
//             keyboardType: TextInputType.number,
//             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//             controller: _textcontroller,
//             autofocus: true,
//             onEditingComplete: () {

//             },
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           ElevatedButton(
//             onPressed: () {
//               final count = int.parse(_textcontroller.text);
//               habitsDatabase.putTodayDataAt(index, count);
//               Navigator.pop(context);
//             },
//             child: Text("submit"),
//           )
//         ],
//       ),
//     );
//   }
// }
