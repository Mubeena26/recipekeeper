

import 'package:flutter/material.dart';
import 'package:recipe_project/db/db_functions.dart';
import 'package:recipe_project/model/data_model.dart';

class SearchResultsScreen extends StatelessWidget {
  final String query;

  SearchResultsScreen({required this.query});

  @override
  Widget build(BuildContext context) {
    // Perform the search based on the query and get search results
    List<RecipeModel> searchResults = performSearch(query);

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          RecipeModel recipe = searchResults[index];
          return ListTile(
            title: Text(recipe.name),
            subtitle: Text(recipe.description),
            // Add onTap to navigate to recipe detail screen or do other actions
          );
        },
      ),
    );
  }

  List<RecipeModel> performSearch(String query) {
    // Implement your search logic here
    // You can use the search query to filter recipes or perform any other search operations
    // For simplicity, let's assume we are searching based on the recipe name only
    List<RecipeModel> allRecipes = recipeListNotifier.value; // Get all recipes
    return allRecipes
        .where((recipe) => recipe.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
