import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../widgets/recipe_form.dart';

class EditRecipeScreen extends StatelessWidget {
  final Recipe recipe;
  const EditRecipeScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(recipe.name),
      ),
      body: const Center(child: RecipeForm()),
    );
  }
}
