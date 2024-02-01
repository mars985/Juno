import 'package:flutter/material.dart';

class dialogBox extends StatelessWidget {
  final textController;

  VoidCallback onCancel;
  VoidCallback onSave;
  dialogBox({
    super.key,
    required this.textController,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: Container(
        height: 120,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
        child: Column(
          children: [
            TextField(
                controller: textController,
                decoration: InputDecoration(border: OutlineInputBorder())),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: onSave,
                  child: Text("save"),
                  color: Colors.cyan,
                ),
                const SizedBox(width: 20),
                MaterialButton(
                  onPressed: onCancel,
                  child: Text("cancel"),
                  color: Colors.cyan,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
