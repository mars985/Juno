import 'package:flutter/material.dart';

class myDrawer extends StatefulWidget {
  final onTap;

  const myDrawer({
    super.key,
    required this.onTap,
  });

  @override
  State<myDrawer> createState() => _myDrawerState();
}

class _myDrawerState extends State<myDrawer> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const DrawerHeader(
                child: Icon(
              Icons.monetization_on,
              size: 40,
            )),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("H O M E"),
              onTap: () {
                widget.onTap(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text("P E O P L E"),
              onTap: () {
                widget.onTap(1);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
