// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:juno/data/databasehabits.dart';
// import 'package:juno/models/tasktile.dart';

// class HabitPage extends StatelessWidget {
//   HabitPage({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final hdb = HabitsDatabase();
//     final _habits = Hive.box("habits");
//     final dayHabits = _habits.get(hdb.getDay());

//     void func(value, indexTask) {
//       DateTime now = DateTime.now();
//       DateTime day = DateTime(now.year, now.month, now.day);

//       var existingData = _habits.get(day);
//       existingData[1] = value;

//       _habits.put(day, existingData);
//     }

//     getValueAt(day, indexCategory, indexTask, indexProperty) {
//       return _habits
//           .get(hdb.getDay())[indexCategory][indexTask][indexProperty]
//           .toString();
//     }

//     putValueAt(day, indexCategory, indexTask, indexProperty) {

//     }

//     return Column(
//       children: [
//         Expanded(
//           child: ListView.builder(
//             itemCount: (_habits.get(hdb.getDay())).length,
//             itemBuilder: (BuildContext context, int indexCategory) {
//               return ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: ((_habits.get(hdb.getDay()))[indexCategory]).length,
//                 itemBuilder: (BuildContext context, int indexTask) {
//                   return TaskTile(
//                     indexTask: indexTask,
//                     indexCategory: indexCategory,
//                     onTap: () {},
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class HabitPage extends StatelessWidget {
  const HabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 2/3,
        crossAxisCount: 2,
      ),
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        return MyTile();
      },
    );
  }
}

class MyTile extends StatelessWidget {
  const MyTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: AspectRatio(
        aspectRatio: 2 / 3,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.amber,
          ),
        ),
      ),
    );
  }
}
