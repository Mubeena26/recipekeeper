import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:recipe_project/db/db_functions.dart';
import 'package:recipe_project/model/data_model.dart';

class EditRecipe extends StatefulWidget {
  final RecipeModel oldRecipe;

  const EditRecipe({Key? key, required this.oldRecipe}) : super(key: key);

  @override
  State<EditRecipe> createState() => _EditRecipeState();
}

class _EditRecipeState extends State<EditRecipe> {
  String? _value;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<TextEditingController> _ingredientNameControllers = [];
  final List<TextEditingController> _ingredientQuantityControllers = [];
  final List<TextEditingController> _ingredientUnitControllers = [];
  final List<TextEditingController> _stepControllers = [];
  late String? _imagePath;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
void initState() {
  super.initState();
  _imagePath = widget.oldRecipe.imagepath;
  _nameController.text = widget.oldRecipe.name;
  _value = widget.oldRecipe.categories;
  _descriptionController.text = widget.oldRecipe.description;

  _ingredientNameControllers.addAll(widget.oldRecipe.ingredients
      .map((ingredient) => TextEditingController(text: ingredient.name)));
_ingredientQuantityControllers.addAll(widget.oldRecipe.ingredients
    .map((ingredient) => TextEditingController(text: ingredient.quantity ?? '')));


  _ingredientUnitControllers.addAll(widget.oldRecipe.ingredients
      .map((ingredient) => TextEditingController()));

  _stepControllers.addAll(widget.oldRecipe.Steps
      .map((step) => TextEditingController(text: step)));
}


  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  void _addStep() {
    setState(() {
      _stepControllers.add(TextEditingController());
    });
  }
void _addIngredient() {
  setState(() {
    _ingredientNameControllers.add(TextEditingController());
    _ingredientQuantityControllers.add(TextEditingController());
    _ingredientUnitControllers.add(TextEditingController());
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Recipe',
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
              children: [
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
                  items: [
                    DropdownMenuItem(
                      child: Text('Breakfast'),
                      value: "Breakfast",
                    ),
                    DropdownMenuItem(
                      child: Text('Main course'),
                      value: "Main course",
                    ),
                    DropdownMenuItem(
                      child: Text('Dessert'),
                      value: "Dessert",
                    ),
                    DropdownMenuItem(
                      child: Text('Snacks'),
                      value: "Snacks",
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
                  final nameController = entry.value;
                  final quantityController = _ingredientQuantityControllers[index];
                  final unitController = _ingredientUnitControllers[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
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
                      child: Text('Add Ingredient', style: TextStyle(color: Colors.green)),
                      // style: ElevatedButton.styleFrom(
                      //   primary: Colors.green,
                      // ),
                    ),
                    // const SizedBox(width: 20),
                const SizedBox(height: 20),
                ..._stepControllers.asMap().entries.map((entry) {
                  final index = entry.key;
                  final controller = entry.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
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
                      const SizedBox(height: 20),
                    ],
                  );
                }).toList(), // ElevatedButton(
                    //   onPressed: _addIngredient,
                    //   child: Text('Add Ingredient', style: TextStyle(color: Colors.white)),
                    //   // style: ElevatedButton.styleFrom(
                    //   //   primary: Colors.green,
                    //   // ),
                    // ),
                    // const SizedBox(width: 20),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ElevatedButton(
                    //   onPressed: _addIngredient,
                    //   child: Text('Add Ingredient', style: TextStyle(color: Colors.white)),
                    //   // style: ElevatedButton.styleFrom(
                    //   //   primary: Colors.green,
                    //   // ),
                    // ),
                    // const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _addStep,
                      child: Text('Add Step', style: TextStyle(color: Colors.green)),
                      // style: ElevatedButton.styleFrom(
                      //   primary: Colors.green,
                      // ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        _nameController.text = '';
                        _descriptionController.text = '';
                        _ingredientNameControllers.forEach((controller) => controller.clear());
                        _ingredientQuantityControllers.forEach((controller) => controller.clear());
                        _ingredientUnitControllers.forEach((controller) => controller.clear());
                        _stepControllers.forEach((controller) => controller.clear());
                      },
                      child: Icon(Icons.close),
                      backgroundColor: Colors.green,
                    ),
                    SizedBox(width: 20),
                   ElevatedButton(
  onPressed: () {
    if (_formKey.currentState!.validate()) {
      final newIngredients = List<Ingredient>.generate(
        _ingredientNameControllers.length,
        (index) => Ingredient(
          name: _ingredientNameControllers[index].text,
          quantity: _ingredientQuantityControllers[index].text, // Assigning as string
          // unit: _ingredientUnitControllers[index].text,
        ),
      );

      final newSteps = _stepControllers.map((controller) => controller.text).toList();

      final newRecipe = RecipeModel(
        name: _nameController.text,
        categories: _value!,
        description: _descriptionController.text,
        ingredients: newIngredients,
        Steps: newSteps,
        imagepath: _imagePath ?? '',
      );

      editRecipe(widget.oldRecipe, newRecipe);
      Navigator.pop(context);
    }
  },
  child:Icon(Icons.check_box,color: Colors.green,)
),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
