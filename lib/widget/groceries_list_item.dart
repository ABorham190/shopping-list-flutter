import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';

class GroceriesListItem extends StatelessWidget {
  const GroceriesListItem({
    super.key,
    required this.groceryItem,
  });
  final GroceryItem groceryItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: ListTile(
          leading: Container(
            height: 24,
            width: 24,
            color: groceryItem.category.color,
          ),
          title: Text(
            groceryItem.name,
          ),
          trailing: Text(
            groceryItem.quantity.toString(),
          ),
        ));
  }
}
