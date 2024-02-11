// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:juno/models/navbar.dart';

class PeoplePage extends StatelessWidget {
  const PeoplePage({super.key});

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: Text("people container"),
    //   color: Colors.amber[800],
    //   width: 50,
    //   height: 50,
    // );
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        // Text(index.toString(),);
        // Text("hi");
        return Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
          child: CustomListTile(index: index),
        );
      },
    );
  }
}

class CustomListTile extends StatefulWidget {
  final int index;
  const CustomListTile({
    super.key,
    required this.index,
  });

  @override
  State<CustomListTile> createState() => _customListTileState();
}

class _customListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        // shape: BeveledRectangleBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(5))),
        leading: CircleAvatar(child: Icon(Icons.person)),
        onTap: () {},
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Person Person"),
            Row(
              children: [
                SvgPicture.asset('assets/money.svg'),
                SizedBox(width: 10,),
                Text("\$ 10000"),
              ],
            ),
          ],
        ),
        // trailing: Checkbox(value: false, onChanged: (value) {}),
      ),
    );
  }
}
