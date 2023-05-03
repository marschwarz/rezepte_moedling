import 'package:flutter/material.dart';

import '../models/recipe.dart';

class EditRecipeScreen extends StatelessWidget {
  final Recipe recipe;
  const EditRecipeScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rezept Editieren'),
      ),
      body: Center(child: Text(recipe.name)),
    );
  }
}
