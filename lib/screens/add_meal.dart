import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recipe_project/db/db_functions.dart';
import 'package:recipe_project/model/data_model.dart';
import 'package:recipe_project/screens/input_field.dart';

class AddMeal extends StatefulWidget {
  final DateTime selectedDate;
  const AddMeal({Key? key, required this.selectedDate}) : super(key: key);

  @override
  State<AddMeal> createState() => _AddMealState();
}

class _AddMealState extends State<AddMeal> {
  late DateTime _selectedDate;
  late TextEditingController _recipeController;
  late TextEditingController _mealController;
  late TextEditingController _sizeController;
  late TextEditingController _notesController;
  late TextEditingController _dateController;
  final _formKey = GlobalKey<FormState>(); 

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
    _recipeController = TextEditingController();
    _mealController = TextEditingController();
    _sizeController = TextEditingController();
    _notesController = TextEditingController();
    _dateController = TextEditingController(
        text: DateFormat.yMd().format(widget.selectedDate));
  }

  @override
  void dispose() {
    _recipeController.dispose();
    _mealController.dispose();
    _sizeController.dispose();
    _notesController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add meal'),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _saveMeal();
              }
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Recipe",
                    hintText: "Recipe or description",
                  ),
                  controller: _recipeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a recipe';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Meal",
                    hintText: "Enter your meal",
                  ),
                  controller: _mealController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a meal';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Date",
                    hintText: "Select date",
                    suffixIcon: IconButton(
                      onPressed: () {
                        _getDateFromUser();
                      },
                      icon: const Icon(Icons.calendar_today_outlined),
                    ),
                  ),
                  controller: _dateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a date';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Size",
                    hintText: "Enter serving size",
                  ),
                  controller: _sizeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a size';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Notes",
                    hintText: "Notes",
                  ),
                  controller: _notesController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some notes';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 35),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Add widgets here if needed
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _saveMeal() {
    String recipe = _recipeController.text;
    String meal = _mealController.text;
    String size = _sizeController.text;
    String notes = _notesController.text;

    // Create a Meal object
    Meal newMeal = Meal(
      date: DateFormat.yMd().format(_selectedDate),
      meal: meal,
      recipe: recipe,
      size: size,
      notes: notes,
    );

    // Save the Meal object
    saveMeal(newMeal);

    // Clear the text fields after saving
    _recipeController.clear();
    _mealController.clear();
    _sizeController.clear();
    _notesController.clear();

    // Pass the selected date back to the AddMealplanner page
    Navigator.pop(context, _selectedDate);

    // Optionally, show a confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Meal saved successfully'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  _getDateFromUser() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2124),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        // Update the text controller of the "Date" input field
        _dateController.text = DateFormat.yMd().format(_selectedDate);
      });
    }
  }
}
