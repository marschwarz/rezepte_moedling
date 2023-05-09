import 'package:flutter/material.dart';

import '../widgets/recipe_form.dart';

class AddRecipeScreen extends StatelessWidget {
  const AddRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rezept Hinzufügen'),
      ),
      body: const Center(child:  RecipeForm()),
    );
  }
}
