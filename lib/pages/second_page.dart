import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage>
    with SingleTickerProviderStateMixin {
  var _textVar = 0;
  var _iconVar = Icons.plus_one;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Second Page!?")),
      body: Center(
        child: Column(
          children: [
            Text("page 2"),
            Text(_textVar.toString()),
            ElevatedButton(
              onPressed: incrementerOfNumbers,
              onHover: (value) {
                setState(() {
                  // _iconVar = Icons.minimize_outlined;
                _iconVar = Icons.maximize_outlined;
                });
              },
              onFocusChange: (value) {
              },
              child: Icon(_iconVar),
            ),
          ],
        ),
      ),
    );
  }

  void incrementerOfNumbers() {
    setState(() {
      _textVar++;
    });
  }
}
