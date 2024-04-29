// ignore_for_file: prefer_final_fields, library_private_types_in_public_api, unused_local_variable, avoid_function_literals_in_foreach_calls

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_project/db/db_functions.dart';
import 'package:recipe_project/model/data_model.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String? _value;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<TextEditingController> _ingredientNameControllers = [];
  final List<TextEditingController> _ingredientQuantityControllers = [];
  final List<TextEditingController> _ingredientUnitControllers = [];
  final List<TextEditingController> _stepControllers = [];
  late String? _imagePath;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<bool> _showRemoveIcon = [false];

  @override
  void initState() {
    super.initState();
    _imagePath = '';
    _ingredientNameControllers.add(TextEditingController());
    _ingredientQuantityControllers.add(TextEditingController());
    _ingredientUnitControllers.add(TextEditingController());

    _stepControllers.add(TextEditingController());
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  void _addStep() {
    setState(() {
      _stepControllers.add(TextEditingController());
      _showRemoveIcon.add(true);
    });
  }

  void _addIngredient() {
    setState(() {
      _ingredientNameControllers.add(TextEditingController());
      _ingredientQuantityControllers.add(TextEditingController());
      _ingredientUnitControllers.add(TextEditingController());
      _showRemoveIcon.add(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    var children = [
      GestureDetector(
        onTap: () {
          _pickImage();
        },
        child: CircleAvatar(
          radius: 50,
          backgroundImage: _imagePath != null && _imagePath!.isNotEmpty
              ? FileImage(File(_imagePath!))
              : null,
          child: _imagePath == null || _imagePath!.isEmpty
              ? const Icon(
                  Icons.add_a_photo,
                  size: 50,
                )
              : null,
        ),
      ),
      const SizedBox(height: 20.0),
      TextFormField(
        controller: _nameController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green,
            ),
          ),
          hintText: 'Name',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter recipe name';
          }
          return null;
        },
      ),
      const SizedBox(height: 10),
      DropdownButtonFormField<String>(
        value: _value,
        items: const [
          DropdownMenuItem(
            value: "Breakfast",
            child: Text('Breakfast'),
          ),
          DropdownMenuItem(
            value: "Main course",
            child: Text('Main course'),
          ),
          DropdownMenuItem(
            value: "Dessert",
            child: Text('Dessert'),
          ),
          DropdownMenuItem(
            value: "Snacks",
            child: Text('Snacks'),
          ),
        ],
        onChanged: (value) {
          setState(() {
            _value = value;
          });
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green,
            ),
          ),
          hintText: 'Select category',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a category';
          }
          return null;
        },
      ),
      const SizedBox(height: 20),
      TextFormField(
        controller: _descriptionController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green,
            ),
          ),
          hintText: 'Description',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter recipe description';
          }
          return null;
        },
      ),
      const SizedBox(height: 20),
      ..._ingredientNameControllers.asMap().entries.map((entry) {
        final index = entry.key;
        final nameController = _ingredientNameControllers[index];
        final quantityController = _ingredientQuantityControllers[index];
        final unitController = _ingredientUnitControllers[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                        ),
                      ),
                      hintText: 'Ingredient Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter ingredient name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                if (_showRemoveIcon[
                    index]) // Display the remove icon conditionally
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        _ingredientNameControllers.removeAt(index);
                        _ingredientQuantityControllers.removeAt(index);
                        _ingredientUnitControllers.removeAt(index);
                        _showRemoveIcon
                            .removeAt(index); // Remove the boolean value
                      });
                    },
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: quantityController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                        ),
                      ),
                      hintText: 'Quantity',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter quantity';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                // Expanded(
                //   child: TextFormField(
                //     controller: unitController,
                //     decoration: const InputDecoration(
                //       border: OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: Colors.green,
                //         ),
                //       ),
                //       hintText: 'Unit',
                //     ),
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return 'Please enter unit';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        );
      }).toList(),
      ElevatedButton(
        onPressed: _addIngredient,
        child:
            const Text('Add Ingredient', style: TextStyle(color: Colors.green)),
      ),
      const SizedBox(height: 20),
      ..._stepControllers.asMap().entries.map((entry) {
        final index = entry.key;
        final controller = entry.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                        ),
                      ),
                      hintText: 'Step ${index + 1}',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter step ${index + 1}';
                      }
                      return null;
                    },
                  ),
                ),
                if (_showRemoveIcon[
                    index]) // Display the remove icon conditionally
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        _stepControllers.removeAt(index);
                        _showRemoveIcon
                            .removeAt(index); // Remove the boolean value
                      });
                    },
                  ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        );
      }).toList(),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //           ElevatedButton(
          //             onPressed: _addIngredient,
          //             child: Text('Add Ingredient', style: TextStyle(color: Colors.white)),
          //             // style: ElevatedButton.styleFrom(
          //             //   primary: Colors.green,
          //             // ),
          //           ),
          //           const SizedBox(width: 20),
          // const SizedBox(width: 30.0),
          ElevatedButton(
            onPressed: _addStep,
            child:
                const Text('Add Step', style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
      const SizedBox(
        height: 10.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              _nameController.text = '';
              _descriptionController.text = '';
              // _ingredientNameControllers.forEach((
              _ingredientNameControllers
                  .forEach((controller) => controller.clear());
              _ingredientQuantityControllers
                  .forEach((controller) => controller.clear());
              _ingredientUnitControllers
                  .forEach((controller) => controller.clear());
              _stepControllers.forEach((controller) => controller.clear());
            },
            child: const Icon(Icons.close, color: Colors.green),
          ),
          const SizedBox(width: 125.0),
          FloatingActionButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final List<Ingredient> ingredients = [];
                for (int i = 0; i < _ingredientNameControllers.length; i++) {
                  final name = _ingredientNameControllers[i].text;
                  final quantity = _ingredientQuantityControllers[i]
                      .text
                      .toString(); // Updated line
                  ingredients.add(Ingredient(name: name, quantity: quantity));
                }

                final newRecipe = RecipeModel(
                  name: _nameController.text,
                  description: _descriptionController.text,
                  ingredients: ingredients,
                  Steps: _stepControllers
                      .map((controller) => controller.text)
                      .toList(),
                  categories: _value!,
                  imagepath: _imagePath ?? '',
                );

                saveRecipe(newRecipe);
                Navigator.pop(context);
              }
            },
            child: const Icon(Icons.check_box, color: Colors.green),
          ),
        ],
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Recipe',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}
