// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TaskEditPage extends StatefulWidget {
  const TaskEditPage({super.key});

  @override
  State<TaskEditPage> createState() => _TaskEditPageState();
}

class _TaskEditPageState extends State<TaskEditPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Flexible(
              child: TextFormField(
                validator: nonNullValidator,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  label: Text("Name"),
                ),
              ),
            ),
            SizedBox(height: 8),
            Flexible(
              child: TextFormField(
                validator: nonNullValidator,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  label: Text("Description"),
                ),
              ),
            ),
            SizedBox(height: 8),
            Flexible(
              child: TextFormField(
                validator: nonNullValidator,
                decoration: InputDecoration(
                  
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  label: Text("Streak Goal"),
                ),
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  String? nonNullValidator(value) {
    if (value == null || value.isEmpty) return "Please enter text";
    return null;
  }
}
