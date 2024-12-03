import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/models/grocery_item.dart';

class GroceriesItemsNotifier extends StateNotifier<List<GroceryItem>> {
  GroceriesItemsNotifier() : super([]);
  void updateGroceriesList(GroceryItem groceryItem) {
    state = [...state, groceryItem];
  }
}

final groceriesAddedItems =
    StateNotifierProvider<GroceriesItemsNotifier, List<GroceryItem>>((ref) {
  return GroceriesItemsNotifier();
});
