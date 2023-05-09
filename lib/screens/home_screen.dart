import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../widgets/recipe_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Recipe> _recipes = [
    Recipe(
        id: "1",
        name: "Palatschinken",
        description: "Palatschinken halt",
        ingredients: "Ohne Eier vegan",
        imageURL:
            "https://images.ichkoche.at/data/image/variations/620x434/7/vegane-palatschinken-img-64793.jpg",
        rating: 5.0),
    Recipe(
        id: "2",
        name: "Veganer Burger",
        description: "Superlecker",
        ingredients: "ganz viel Soja",
        rating: 4.0),
    Recipe(
        id: "3",
        name: "Vegane Pizza",
        description: "Echt fettig",
        ingredients: "ohne Käse",
        rating: 3.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meine Lieblingsrezepte"),
      ),
      body: _recipes.isNotEmpty
          ? ListView.builder(
              itemCount: _recipes.length,
              itemBuilder: (BuildContext context, int index) {
                final Recipe recipe = _recipes[index];
                return RecipeItem(
                  recipe: recipe,
                  onDeletePressed: () {
                    setState(() {
                      _recipes.removeAt(index);
                    });
                  },
                  onEditPressed: () async {
                    final newRecipe = await Navigator.pushNamed(
                         context, '/edit_recipe',
                         arguments: recipe) as Recipe?;
                      if (newRecipe != null) {
                         updateRecipe(newRecipe);
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
                setState((){
                  _recipes.add(newRecipe);
                });
              }
            },
            tooltip: 'Rezept hinzufügen',
            child: const Icon(Icons.restaurant),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildPlaceholder() {
    return const Center(
        child: Text(
      'Noch keine Rezepte hinzugefügt',
    ));
  }

void updateRecipe(Recipe updatedRecipe) {
  final index = _recipes.indexWhere((recipe) => recipe.id == updatedRecipe.id);
    if (index != -1) {
      setState(() {
        _recipes[index] = updatedRecipe;
      });
    }
  }

}
