import 'package:flutter/material.dart';
import 'package:shopping_list/screens/add_new_item_screen.dart';
import 'package:shopping_list/widget/groceries_list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/providers/groceries_items_provider.dart';

class GroceriesScreen extends ConsumerStatefulWidget {
  const GroceriesScreen({
    super.key,
  });

  @override
  ConsumerState<GroceriesScreen> createState() => _GroceriesScreenState();
}

class _GroceriesScreenState extends ConsumerState<GroceriesScreen> {
  void _addNewItem() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const AddNewItemScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var grocItems = ref.watch(groceriesAddedItems);
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
        itemCount: grocItems.length,
        itemBuilder: (ctx, index) => GroceriesListItem(
          groceryItem: grocItems[grocItems.length - 1 - index],
        ),
      ),
    );
  }
}
