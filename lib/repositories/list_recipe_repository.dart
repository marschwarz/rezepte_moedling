
import '../models/recipe.dart';
import 'recipe_repository.dart';

class ListRecipeRepository extends RecipeRepository{
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
  Future<List<Recipe>> getAllRecipes() async{
    return _recipes;
  }

    @override
  Future<Recipe> getRecipe(String id) async{
    return _recipes.firstWhere((recipe) => recipe.id == id);
  }

    @override
  Future<void> addRecipe(Recipe recipe) async{
    _recipes.add(recipe);
    notifyListeners();
  }

  @override
  Future<void> updateRecipe(Recipe recipe) async{
  final index = _recipes.indexWhere((checkedRecipe) => checkedRecipe.id == recipe.id);
    _recipes[index] = recipe;
  notifyListeners();
  }
  Future<void> deleteRecipe(String id) async{
    _recipes.removeWhere((recipe) => recipe.id == id);
    notifyListeners();
  }

}