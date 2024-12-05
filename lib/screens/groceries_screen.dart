import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/screens/add_new_item_screen.dart';
import 'package:shopping_list/widget/groceries_list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class GroceriesScreen extends ConsumerStatefulWidget {
  const GroceriesScreen({
    super.key,
  });

  @override
  ConsumerState<GroceriesScreen> createState() => _GroceriesScreenState();
}

class _GroceriesScreenState extends ConsumerState<GroceriesScreen> {
  List<GroceryItem> grocItems = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https(
        'shop-project-3c04c-default-rtdb.firebaseio.com', '/shoping_list.json');
    final response = await http.get(url);
    if (response.statusCode >= 400) {
      setState(() {
        _errorMessage = 'Faild to download...try again later';
      });
      return;
    }
    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> loadedItems = [];
    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere(
              (catItem) => catItem.value.title == item.value['category'])
          .value;
      loadedItems.add(
        GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        ),
      );
    }
    setState(() {
      grocItems = loadedItems;
      _isLoading = false;
    });
    print(loadedItems);
  }

  void _addNewItem() async {
    final addedItem = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const AddNewItemScreen(),
      ),
    );
    if (addedItem == null) {
      return;
    }
    setState(() {
      grocItems.add(addedItem);
    });
  }

  void _removeGroceryFromGroceryItems(GroceryItem groceryItem) {
    final groceryItemIndex = grocItems.indexOf(groceryItem);
    setState(() {
      grocItems.remove(groceryItem);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Grocery item removed successfully'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                grocItems.insert(groceryItemIndex, groceryItem);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget activeWidget = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Uh..Oh There is no grocries right now',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
    if (_isLoading) {
      activeWidget = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (grocItems.isNotEmpty) {
      activeWidget = ListView.builder(
        itemCount: grocItems.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(
            grocItems[grocItems.length - 1 - index],
          ),
          background: Container(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(.75),
            margin: const EdgeInsets.symmetric(horizontal: 8),
          ),
          onDismissed: (direction) => {
            _removeGroceryFromGroceryItems(
              grocItems[grocItems.length - 1 - index],
            ),
          },
          child: GroceriesListItem(
            groceryItem: grocItems[grocItems.length - 1 - index],
          ),
        ),
      );
    }
    if (_errorMessage != null) {
      activeWidget = Center(
        child: Text(_errorMessage!),
      );
    }
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
      body: activeWidget,
    );
  }
}
