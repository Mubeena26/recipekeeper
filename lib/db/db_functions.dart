// import 'dart:js_util';

// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:recipe_project/model/data_model.dart';

ValueNotifier<List<RecipeModel>> recipeListNotifier = ValueNotifier([]);
void saveRecipe(RecipeModel recipe) async {
  try {
    final recipeBox = await Hive.openBox<RecipeModel>('recipe');
    await recipeBox.add(recipe);
    recipeListNotifier.value.add(recipe);
    recipeListNotifier.notifyListeners();
  } catch (e) {
    print('Error saving recipe: $e');
  }
}

Future<void> getRecipes() async {
  final recipeBox = await Hive.openBox<RecipeModel>('recipe');
  recipeListNotifier.value.clear();
  recipeListNotifier.value.addAll(recipeBox.values);
}

List<RecipeModel> getRecipesByCategory(String category) {
  final recipeBox = Hive.box<RecipeModel>('recipe');
  return recipeBox.values
      .where((recipe) => recipe.categories == category)
      .toList();
}

void deleteRecipe(RecipeModel recipe) {
  final recipeBox = Hive.box<RecipeModel>('recipe');
  int index = recipeBox.values.toList().indexWhere((r) => r == recipe);
  if (index != -1) {
    recipeBox.deleteAt(index);
  }

  final favoriteBox = Hive.box<RecipeModel>('favorites');
  favoriteBox.delete(recipe.name);
  final ingredientBox = Hive.box<Ingredient>('ingredients');
  for (Ingredient ingredient in recipe.ingredients) {
    ingredientBox.delete(ingredient.name);
  }
}

void deleteIngredient(Ingredient ingredient) {
  final ingredientBox = Hive.box<Ingredient>('ingredients');
  int index = ingredientBox.values.toList().indexWhere((r) => r == ingredient);
  if (index != -1) {
    ingredientBox.deleteAt(index);
  }
}

void editRecipe(RecipeModel oldRecipe, RecipeModel newRecipe) async {
  final recipeBox = await Hive.openBox<RecipeModel>('recipe');

  int index = recipeBox.values.toList().indexWhere((r) => r == oldRecipe);

  if (index != -1) {
    await recipeBox.putAt(index, newRecipe);

    int notifierIndex = recipeListNotifier.value.indexOf(oldRecipe);
    if (notifierIndex != -1) {
      recipeListNotifier.value[notifierIndex] = newRecipe;
      recipeListNotifier.notifyListeners();
    }
  }
}

void saveFavoriteRecipe(RecipeModel recipe) async {
  final favoriteBox = await Hive.openBox<RecipeModel>('favorites');
  await favoriteBox.put(recipe.name, recipe);
}

void removeFavoriteRecipe(RecipeModel recipe) async {
  final favoriteBox = await Hive.openBox<RecipeModel>('favorites');
  await favoriteBox.delete(recipe.name);
}

void saveIngredients(RecipeModel recipe) async {
  final ingredientBox = await Hive.openBox<Ingredient>('ingredients');
  for (Ingredient ingredient in recipe.ingredients) {
    if (!ingredientBox.containsKey(ingredient.name)) {
      // Add to ingredientBox only if it doesn't already exist
      await ingredientBox.put(ingredient.name, ingredient);
    }
  }
}

Future<List<Ingredient>> getIngredients() async {
  final ingredientBox = await Hive.openBox<Ingredient>('ingredients');
  return ingredientBox.values.toList();
}

Future<void> editIngredients(
    Ingredient oldIngredient, Ingredient newIngredient) async {
  final ingredientBox = await Hive.openBox<Ingredient>('ingredients');
  int index =
      ingredientBox.values.toList().indexWhere((i) => i == oldIngredient);
  if (index != -1) {
    await ingredientBox.putAt(index, newIngredient);
  }
}

Future<void> saveMeal(Meal meal) async {
  final mealBox = await Hive.openBox<Meal>('meal');
  await mealBox.add(meal);
}

Future<List<Meal>> getMealsForDate(DateTime date) async {
  try {
    final mealBox = await Hive.openBox<Meal>('meal');
    final List<Meal> allMeals = mealBox.values.toList();

    // Filter the list of meals to get meals for the specified date
    final List<Meal> mealsForDate = allMeals
        .where((meal) => meal.date == DateFormat.yMd().format(date))
        .toList();

    return mealsForDate;
  } catch (e) {
    print('Error fetching meals for date: $e');
    return []; // Return an empty list if an error occurs
  }
}

// void deleteMeal(Meal meal) {
//   final mealBox = Hive.box<Meal>('meal');
//   print('Deleting meal with key: ${meal.recipe}');
//   mealBox.delete(
//       meal.meal); // Assuming meal.recipe represents the unique key of the meal
// }

void deleteMeal(Meal meal) {
  final mealBox = Hive.box<Meal>('meal');
  int index = mealBox.values.toList().indexWhere((r) => r == meal);
  if (index != -1) {
    mealBox.deleteAt(index);
  }
}
