import 'package:shared_preferences/shared_preferences.dart';

import '../models/recipe.dart';
import 'recipe_repository.dart';

class LocalRecipeRepository extends RecipeRepository {
  SharedPreferences? _prefs;
  Future<SharedPreferences> _getPrefs() async {
    if (_prefs != null) {
      return _prefs!;
    }
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }

  @override
  Future<List<Recipe>> getAllRecipes() async {
    final prefs = await _getPrefs();
    final recipes = <Recipe>[];
    prefs.getKeys().forEach((key) {
      if (key.startsWith('recipe_')) {
        final recipeJson = prefs.getString(key);
        if (recipeJson != null) {
          final recipe = Recipe.fromJson(recipeJson);
          recipes.add(recipe);
        }
      }
    });
    return recipes;
  }

  @override
  Future<Recipe?> getRecipe(String id) async {
    final prefs = await _getPrefs();
    final recipeJson = prefs.getString('recipe_$id');
    return recipeJson != null ? Recipe.fromJson(recipeJson) : null;
  }

  @override
  Future<void> addRecipe(Recipe recipe) async {
    final prefs = await _getPrefs();
    await prefs.setString('recipe_${recipe.id}', recipe.toJson());
    notifyListeners();
  }

  @override
  Future<void> updateRecipe(Recipe recipe) async {
    final prefs = await _getPrefs();
    await prefs.setString('recipe_${recipe.id}', recipe.toJson());
    notifyListeners();
  }

  @override
  Future<void> deleteRecipe(String id) async {
    final prefs = await _getPrefs();
    await prefs.remove('recipe_$id');
    notifyListeners();
  }
}
