import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe.dart';
import '../repositories/recipe_repository.dart';
import '../widgets/recipe_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
final recipeRepo = Provider.of<RecipeRepository>(context);
    return FutureBuilder(
      future: recipeRepo.getAllRecipes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              final recipes = snapshot.data!;
              return Scaffold(
          appBar: AppBar(
            title: const Text("Meine Lieblingsrezepte"),
          ),
          body: recipes.isNotEmpty
              ? ListView.builder(
                  itemCount: recipes.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Recipe recipe = recipes[index];
                    return RecipeItem(
                      recipe: recipe,
                      onDeletePressed: () {
                         recipeRepo.deleteRecipe(recipe.id);
                      },
                      onEditPressed: () async {
                        final newRecipe = await Navigator.pushNamed(
                             context, '/edit_recipe',
                             arguments: recipe) as Recipe?;
                          if (newRecipe != null) {
                             await recipeRepo.updateRecipe(newRecipe);
                          }
                        },

                    );
                  })
              : _buildPlaceholder(),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: 'btn1',
                onPressed: () {},
                tooltip: 'Ähnliches Rezept generieren',
                child: const Icon(Icons.psychology),
              ),
              const SizedBox(width: 12),
              FloatingActionButton(
                heroTag: 'btn2',
                onPressed: () async {
                  final newRecipe = await Navigator.pushNamed(context, '/add_recipe') as Recipe?;
                  if (newRecipe != null){
                    await recipeRepo.addRecipe(newRecipe);
                  }
                },
                tooltip: 'Rezept hinzufügen',
                child: const Icon(Icons.restaurant),
              ),
            ],
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      }else{
        return Scaffold(
          appBar: AppBar(
            title: const Text("Meine Lieblingsrezepte"),
          ),
          body: _buildPlaceholder(),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: 'btn1',
                onPressed: () {},
                tooltip: 'Ähnliches Rezept generieren',
                child: const Icon(Icons.psychology),
              ),
              const SizedBox(width: 12),
              FloatingActionButton(
                heroTag: 'btn2',
                onPressed: () async {
                  final newRecipe = await Navigator.pushNamed(context, '/add_recipe') as Recipe?;
                  if (newRecipe != null){
                    await recipeRepo.addRecipe(newRecipe);
                  }
                },
                tooltip: 'Rezept hinzufügen',
                child: const Icon(Icons.restaurant),
              ),
            ],
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      }}
    );
  }

  Widget _buildPlaceholder() {
    return const Center(
        child: Text(
      'Noch keine Rezepte hinzugefügt',
    ));
  }



}
