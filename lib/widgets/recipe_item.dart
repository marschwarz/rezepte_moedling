import 'dart:math';

import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeItem extends StatelessWidget {
  const RecipeItem({
    super.key,
    required this.recipe,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  final Recipe recipe;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(recipe.imageURL),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/recipe_detail', arguments: recipe);
        },
        title: Text(recipe.name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(onPressed: onEditPressed, icon: const Icon(Icons.edit)),
            IconButton(
                onPressed: onDeletePressed, icon: const Icon(Icons.delete)),
          ],
        ));
    //Text(recipe.rating.toString()));
  }
}
