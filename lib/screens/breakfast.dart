// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_project/db/db_functions.dart';
import 'package:recipe_project/model/data_model.dart';

import 'package:recipe_project/screens/recipe_detail.dart';

class Breakfast extends StatefulWidget {
  const Breakfast({Key? key});

  @override
  State<Breakfast> createState() => _BreakfastState();
}

class _BreakfastState extends State<Breakfast> {
  late List<RecipeModel> breakfastRecipes = [];

  @override
  void initState() {
    super.initState();
    // Fetch recipes by category when the widget initializes
    getRecipeByCategory();
    // Open the 'favorites' box when the widget initializes
    openFavoritesBox();
  }

  Future<void> getRecipeByCategory() async {
    final recipeBox = await Hive.openBox<RecipeModel>('recipe');
    final List<RecipeModel> recipes = [];
    await Future.forEach(recipeBox.values, (RecipeModel recipe) {
      if (recipe.categories == 'Breakfast') {
        recipes.add(recipe);
      }
    });
    setState(() {
      breakfastRecipes = recipes;
    });
  }

  Future<void> openFavoritesBox() async {
    // Open the 'favorites' box
    await Hive.openBox<RecipeModel>('favorites');
  }

  void saveFavoriteRecipe(RecipeModel recipe) async {
    final favoriteBox = await Hive.openBox<RecipeModel>('favorites');
    // Toggle favorite status
    if (favoriteBox.containsKey(recipe.name)) {
      // Remove from favorites if already favorite
      await favoriteBox.delete(recipe.name);
    } else {
      // Add to favorites if not favorite
      await favoriteBox.put(recipe.name, recipe);
    }
  }

  @override
  Widget build(BuildContext context) {
    // getRecipeByCategory();
    return ValueListenableBuilder(
      valueListenable: Hive.box<RecipeModel>('favorites').listenable(),
      builder: (context, Box<RecipeModel> favoritesBox, _) {
        final favoriteRecipes = favoritesBox.values.toList();
        return breakfastRecipes.isEmpty
            ? const Center(
                child: Text('No recipes found in Breakfast category'),
              )
            : ListView.separated(
                itemBuilder: (ctx, index) {
                  final RecipeModel recipe = breakfastRecipes[index];
                  final isFavorite = favoriteRecipes.contains(recipe);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetail(
                            recipe: recipe,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 2,
                        child: ListTile(
                          title: Text(recipe.name),
                          subtitle: Text(recipe.description),
                          leading: CircleAvatar(
                            radius: 30,
                            // ignore: unnecessary_null_comparison
                            backgroundImage: recipe.imagepath != null
                                ? FileImage(File(recipe.imagepath))
                                : null,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  // Update 'favorites' box with the recipe
                                  saveFavoriteRecipe(recipe);
                                },
                                icon: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFavorite ? Colors.red : null,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete_forever_outlined,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  deleteRecipe(recipe);
                                  getRecipeByCategory(); // Update recipes after deletion
                                  // Show a SnackBar to confirm successful deletion
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Recipe deleted successfully.'),
                                      duration: Duration(
                                          seconds:
                                              2), // Adjust the duration as needed
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: breakfastRecipes.length,
              );
      },
    );
  }
}
