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

class DoTaskDialog extends StatelessWidget {
  DoTaskDialog({
    super.key,
    required this.habitsDatabase,
    required this.index,
  });

  final TextEditingController _textcontroller = TextEditingController();
  final HabitsDatabase habitsDatabase;
  final int index;

  void submitTask(BuildContext context) {
    _textcontroller.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            controller: _textcontroller,
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              final count = int.parse(_textcontroller.text);
              print(count);
              print(count.runtimeType);
              habitsDatabase.putTodayDataAt(index, count);
              Navigator.pop(context);
            },
            child: Text("submit"),
          )
        ],
      ),
    );
  }
}

// class TimePickerDemo extends StatefulWidget {
//   @override
//   _TimePickerDemoState createState() => _TimePickerDemoState();
// }

// class _TimePickerDemoState extends State<TimePickerDemo> {
//   TimeOfDay _selectedTime = TimeOfDay.now();

//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: _selectedTime ?? TimeOfDay.now(),
//     );
//     if (picked != null && picked != _selectedTime) {
//       setState(() {
//         _selectedTime = picked;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Time Picker Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               _selectedTime != null
//                   ? 'Selected Time: ${_selectedTime.hour}:${_selectedTime.minute}'
//                   : 'Select a time',
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _selectTime(context),
//               child: Text('Select Time'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CustomTimePickerDialog extends StatefulWidget {
//   @override
//   _CustomTimePickerDialogState createState() => _CustomTimePickerDialogState();
// }

// class _CustomTimePickerDialogState extends State<CustomTimePickerDialog> {
//   TimeOfDay _selectedTime = TimeOfDay.now();

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Select Time'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           SizedBox(
//             height: 200,
//             child: TimePicker(
//               initialTime: _selectedTime,
//               onTimeChanged: (TimeOfDay newTime) {
//                 setState(() {
//                   _selectedTime = newTime;
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//       actions: <Widget>[
//         ElevatedButton(
//           onPressed: () {
//             Navigator.of(context).pop(); // Close the dialog
//           },
//           child: Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             Navigator.of(context).pop(_selectedTime); // Pass back the selected time
//           },
//           child: Text('OK'),
//         ),
//       ],
//     );
//   }
// }

// class TimePicker extends StatelessWidget {
//   final TimeOfDay initialTime;
//   final Function(TimeOfDay) onTimeChanged;

//   TimePicker({required this.initialTime, required this.onTimeChanged,});

//   @override
//   Widget build(BuildContext context) {
//     return MediaQuery(
//       data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
//       child: Builder(
//         builder: (context) {
//           return Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: 200,
//                 child: TimePickerDialog(
//                   initialTime: initialTime,
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
