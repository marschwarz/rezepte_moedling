import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../models/recipe.dart';
import '../repositories/recipe_repository.dart';

class DetailsScreen extends StatelessWidget {
  final Recipe recipe;
  const DetailsScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
final recipeRepo = Provider.of<RecipeRepository>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(recipe.name),
          actions: [
            IconButton(
                onPressed: () async {
                  final newRecipe = Navigator.pushReplacementNamed(context, '/edit_recipe',
                      arguments: recipe) as Recipe?;
                      if (newRecipe != null) {
                        recipeRepo.updateRecipe(newRecipe);
                      }
                },
                icon: const Icon(Icons.edit)),

                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                  recipeRepo.deleteRecipe(recipe.id);
                  Navigator.pop(context);
                  },
                  ),

          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.network(recipe.imageURL, height: 200, fit: BoxFit.cover),
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < recipe.rating.floor(); i++)
                            const Icon(Icons.star, color: Colors.amber),
                          if (recipe.rating - recipe.rating.floor() > 0.0)
                            const Icon(Icons.star_half, color: Colors.amber),
                          for (int i = 0; i < 5 - recipe.rating.ceil(); i++)
                            const Icon(Icons.star_border, color: Colors.amber),
                        ],
                      ),
                      Text(
                        recipe.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),
                      ),
                      const SizedBox(height: 8),
                      const Text("Rezept:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      const SizedBox(height: 8),
                      Text(recipe.description),
                      const SizedBox(height: 16),
                      const Text("Zutaten:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      const SizedBox(height: 8),
                      Text(recipe.ingredients),
                      const SizedBox(height: 16.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.edit),
                          label: const Text('Bearbeiten'),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/edit_recipe',
                              arguments: recipe,
                            );
                          },
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }
}
