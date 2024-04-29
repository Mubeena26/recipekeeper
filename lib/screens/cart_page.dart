// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:recipe_project/db/db_functions.dart';
import 'package:recipe_project/model/data_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Ingredient> ingredients = [];

  @override
  void initState() {
    super.initState();
    _fetchIngredients();
  }

  Future<void> _fetchIngredients() async {
    ingredients = await getIngredients();
    setState(() {});
  }

  void _editIngredient(BuildContext context, Ingredient ingredient) {
    // Controllers for input fields
    TextEditingController nameController =
        TextEditingController(text: ingredient.name);
    TextEditingController quantityController =
        TextEditingController(text: ingredient.quantity);

    // Show dialog box to edit ingredient
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Return your custom dialog box widget
        return AlertDialog(
          title: const Text('Edit Ingredient'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                deleteIngredient(ingredient);
                Navigator.of(context).pop();
                _fetchIngredients();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('ingredient deleted successfully.'),
                    duration:
                        Duration(seconds: 2), // Adjust the duration as needed
                  ),
                );
              },
              child: Text('delete'),
            ),
            ElevatedButton(
              onPressed: () async {
                editIngredients(
                    ingredient,
                    Ingredient(
                      name: nameController.text,
                      quantity: quantityController.text,
                    ));
                Navigator.of(context).pop();
                await _fetchIngredients();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _fetchIngredients();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Container(
        decoration:
            BoxDecoration(border: Border.all(width: 2.0, color: Colors.green)),
        child: ListView.builder(
          itemCount: ingredients.length,
          itemBuilder: (context, index) {
            final ingredient = ingredients[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 2,
                child: ListTile(
                  title: Text(ingredient.name),
                  subtitle: Text('${ingredient.quantity} '),
                  trailing: IconButton(
                    onPressed: () {
                      _editIngredient(context, ingredient);
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
