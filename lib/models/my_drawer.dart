import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  final void Function(int) onTap;

  const MyDrawer({
    super.key,
    required this.onTap,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  onTapp(index) {
    widget.onTap(index);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
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
              onTap: () => onTapp(0),
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text("P E O P L E"),
              onTap: () => onTapp(1),
            ),
            DrawerHeader(
              child: Icon(Icons.checklist, size: 40,),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text("D A S H B O A R D"),
              onTap: () => onTapp(2),
            ),
          ],
        ),
      ),
    );
  }
}
