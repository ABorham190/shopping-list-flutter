import 'package:flutter/material.dart';
import 'package:shopping_list/data/dummy_items.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/screens/add_new_item_screen.dart';
import 'package:shopping_list/widget/groceries_list_item.dart';

class GroceriesScreen extends StatefulWidget {
  const GroceriesScreen({
    super.key,
  });

  @override
  State<GroceriesScreen> createState() => _GroceriesScreenState();
}

class _GroceriesScreenState extends State<GroceriesScreen> {
  final List<GroceryItem> _groceryItems = [];

  void _addNewItem() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const AddNewItemScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Groceries',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        actions: [
          IconButton(
            onPressed: _addNewItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (ctx, index) => GroceriesListItem(
          groceryItem: groceryItems[groceryItems.length - 1 - index],
        ),
      ),
    );
  }
}
