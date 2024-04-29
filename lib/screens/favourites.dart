// ignore_for_file: unnecessary_null_comparison
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:recipe_project/model/data_model.dart';
import 'package:recipe_project/screens/recipe_detail.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  List<RecipeModel> favoriteRecipes = [];

  @override
  void initState() {
    super.initState();
    fetchFavoriteRecipes();
    // Fetch favorite recipes when the widget initializes
    openFavoritesBox();
  }

  Future<void> openFavoritesBox() async {
    // Open the 'favorites' box
    await Hive.openBox<RecipeModel>('favorites');
  }

  Future<List<RecipeModel>> getFavoriteRecipes() async {
    final favoriteBox = await Hive.openBox<RecipeModel>('favorites');
    final favoriteRecipes = favoriteBox.values.toList();
    return favoriteRecipes;
  }

  Future<void> fetchFavoriteRecipes() async {
    // Retrieve favorite recipes from database
    List<RecipeModel> favorites = await getFavoriteRecipes();
    setState(() {
      favoriteRecipes = favorites;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Recipes'),
      ),
      body: Container(
        decoration:
            BoxDecoration(border: Border.all(width: 2.0, color: Colors.green)),
        child: ValueListenableBuilder(
          valueListenable: Hive.box<RecipeModel>('favorites').listenable(),
          builder: (context, Box<RecipeModel> favoritesBox, _) {
            final favoriteRecipes = favoritesBox.values.toList();
            return favoriteRecipes.isEmpty
                ? Center(
                    child: Text('No favourite recipe is found'),
                  )
                : ListView.builder(
                    itemCount: favoriteRecipes.length,
                    itemBuilder: (context, index) {
                      final recipe = favoriteRecipes[index];
                      final isFavorite = favoriteRecipes.contains(recipe);
                      return ListTile(
                        title: Text(recipe.name),
                        subtitle: Text(recipe.description),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: recipe.imagepath != null
                              ? FileImage(File(recipe.imagepath))
                              : null,
                        ),
                        onTap: () {
                          // Navigate to recipe detail screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeDetail(
                                recipe: recipe,
                              ),
                            ),
                          );
                        },
                        trailing: IconButton(
                          onPressed: () async {
                            // Update 'favorites' box with the recipe
                            saveFavoriteRecipe(recipe);
                          },
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : null,
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
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
}
