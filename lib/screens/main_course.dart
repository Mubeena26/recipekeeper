import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_project/db/db_functions.dart';
import 'package:recipe_project/model/data_model.dart';
import 'package:recipe_project/screens/recipe_detail.dart';

class Maincourse extends StatefulWidget {
  const Maincourse({super.key});

  @override
  State<Maincourse> createState() => _MaincourseState();
}

class _MaincourseState extends State<Maincourse> {
  late List<RecipeModel> maincourseRecipes = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecipeByCategory();
    openFavoritesBox();
    //  fetchRecipes();
  }

  Future<void> getRecipeByCategory() async {
    final recipeBox = await Hive.openBox<RecipeModel>('recipe');
    final List<RecipeModel> recipes = [];
    await Future.forEach(recipeBox.values, (RecipeModel recipe) {
      if (recipe.categories == 'Main course') {
        recipes.add(recipe);
      }
    });
    setState(() {
      maincourseRecipes = recipes;
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
  // Future<void> fetchRecipes() async {
  //   // Fetch recipes by category
  //   maincourseRecipes = await getRecipesByCategory('Main course');
  //   // Update the UI with the fetched recipes
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    getRecipeByCategory();
    return ValueListenableBuilder(
        valueListenable: Hive.box<RecipeModel>('favorites').listenable(),
        builder: (context, Box<RecipeModel> favoritesBox, _) {
          final favoriteRecipes = favoritesBox.values.toList();

          return maincourseRecipes.isEmpty
              ? Center(
                  child: Text('No recipes found in Main course category'),
                )
              : ListView.separated(
                  itemBuilder: (ctx, index) {
                    final RecipeModel recipe = maincourseRecipes[index];
                    final isFavorite = favoriteRecipes.contains(recipe);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 2,
                        child: ListTile(
                          title: Text(recipe.name),
                          subtitle: Text(recipe.description),
                          leading: CircleAvatar(
                            radius: 30,
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
//                    IconButton(
//   icon: Icon(
//     recipe.isFavourite ? Icons.favorite : Icons.favorite_border,
//     color: recipe.isFavourite ? Colors.red : Colors.grey,
//   ),
//   onPressed: () {
//     setState(() {
//       recipe.isFavourite = !recipe.isFavourite; // Toggle the favorite status
//     });
//     if (recipe.isFavourite) {
//       saveFavoriteRecipe(recipe); // Save the recipe as favorite
//     } else {
//       removeFavoriteRecipe(recipe); // Remove the recipe from favorites
//     }
//   },
// ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  deleteRecipe(recipe);
                                  getRecipeByCategory(); // Update recipes after deletion
                                  // Show a SnackBar to confirm successful deletion
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RecipeDetail(
                                        recipe: recipe,
                                      )),
                            );
                            // Handle onTap event
                          },
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: maincourseRecipes.length,
                );
        });
  }
}

// Future<void> getRecipeByCategory() async {
//   final recipeBox = await Hive.openBox<RecipeModel>('recipe');
//   await Future.forEach(recipeBox.values, (RecipeModel recipe) {
//     if (recipe.categories == 'Breakfast') {
//       BreakfastListNotifier.value.add(recipe);
//     } else if (recipe.categories == 'Maincourse') {
//       MaincourseListNotifier.value.add(recipe);
//     } else if (recipe.categories == 'Snacks') {
//       SnacksListNotifier.value.add(recipe);
//     } else if (recipe.categories == 'Dessert') {
//       DesertListNotifier.value.add(recipe);
//     }
//   });
// }
