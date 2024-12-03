import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';

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
  var _enterdName = '';
  var _eneredQuantity = 1;
  var _selectedCategory = categories[Categories.vegetables];
  final _formKey = GlobalKey<FormState>();

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(_enterdName);
      print(_eneredQuantity);
      print(_selectedCategory);
    }
  }

  void _reset() {
    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length < 2 ||
                      value.trim().length > 50) {
                    return 'Must be from 2 to 50 characters';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enterdName = value!;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: _eneredQuantity.toString(),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! < 1) {
                          return 'Must be correct positive number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _eneredQuantity = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _selectedCategory,
                      items: [
                        for (final item in categories.entries)
                          DropdownMenuItem(
                            value: item.value,
                            child: Row(
                              children: [
                                Container(
                                  height: 15,
                                  width: 15,
                                  color: item.value.color,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(item.value.title),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        _selectedCategory = value!;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _reset,
                    child: const Text(
                      'Reset',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _saveItem,
                    child: const Text(
                      'Add',
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
