import 'package:flutter/material.dart';

class HabitPage extends StatelessWidget {
  const HabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Checkbox(
            value: false,
            onChanged: (value) {},
            
          ),
          title: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Work out", style: TextStyle(fontSize: 16),),
              Text("07:30", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),)
            ],
          ),
        );
      },
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
    );
  }
}
