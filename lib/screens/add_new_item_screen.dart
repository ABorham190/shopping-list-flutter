import 'package:flutter/material.dart';

class AddNewItemScreen extends StatefulWidget {
  const AddNewItemScreen({
    super.key,
  });

  @override
  State<AddNewItemScreen> createState() {
    return _AddNewItemScreen();
  }
}

class _AddNewItemScreen extends State<AddNewItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                validator: (value) {
                  return 'demo';
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
