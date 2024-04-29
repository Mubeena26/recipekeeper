// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipe_project/db/db_functions.dart';
import 'package:recipe_project/model/data_model.dart';
import 'package:recipe_project/screens/edit_recipe.dart';

class RecipeDetail extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeDetail({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.green,
        title: Text('Recipe Detail'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditRecipe(oldRecipe: recipe),
                ),
              );
            },
            icon: Icon(Icons.edit),
          ),
          SizedBox(
            width: 5.0,
          ),
        ],
      ),
      body: Container(
        decoration:
            BoxDecoration(border: Border.all(width: 2.0, color: Colors.green)),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: recipe.imagepath != null
                        ? FileImage(File(recipe.imagepath))
                            as ImageProvider<Object>
                        : AssetImage('assets/placeholder_image.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Divider(
                thickness: 2,
                color: Colors.green,
              ),
              Container(
                color: Color.fromARGB(255, 10, 109, 13),
                height: 500,
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${recipe.name}',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Description: ${recipe.description}',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Categories: ${recipe.categories}',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Ingredients:',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    for (Ingredient ingredient in recipe.ingredients)
                      Text(
                        '- ${ingredient.name}: ${ingredient.quantity} ',
                      ),
                    SizedBox(height: 16),
                    Text(
                      'Steps:',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    for (String step in recipe.Steps) Text('- $step'),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        saveIngredients(recipe);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Recipe successfully Added.'),
                            duration: Duration(
                                seconds: 2), // Adjust the duration as needed
                          ),
                        );
                        // You can add your logic for adding ingredients to cart here
                      },
                      child: Text(
                        'Add To Cart',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: TextButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => (),
                    //   ),
                    // );
                  },
                  child: Text(
                    'Show More',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
