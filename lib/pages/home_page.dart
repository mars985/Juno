import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return const Padding(
          padding: EdgeInsets.only(
            top: 12,
          ),
          child: ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Person Person",
                  style: TextStyle(),
                ),
              ],
            ),
            trailing: Text("\$1000"),
          ),
        );
      },
    );
  }
}
