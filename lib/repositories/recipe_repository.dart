import 'package:flutter/material.dart';
import '../models/recipe.dart';

abstract class RecipeRepository extends ChangeNotifier {
  Future<List<Recipe>> getAllRecipes();
  Future<Recipe?> getRecipe(String id);
  Future<void> addRecipe(Recipe recipe);
  Future<void> updateRecipe(Recipe recipe);
  Future<void> deleteRecipe(String id);
}
