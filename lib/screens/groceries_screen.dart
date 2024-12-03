import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/screens/add_new_item_screen.dart';
import 'package:shopping_list/widget/groceries_list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroceriesScreen extends ConsumerStatefulWidget {
  const GroceriesScreen({
    super.key,
  });

  @override
  ConsumerState<GroceriesScreen> createState() => _GroceriesScreenState();
}

class _GroceriesScreenState extends ConsumerState<GroceriesScreen> {
  final List<GroceryItem> grocItems = [];
  void _addNewItem() async {
    var newitem = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const AddNewItemScreen(),
      ),
    );
    if (newitem == null) {
      return;
    }
    setState(() {
      grocItems.add(newitem);
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
