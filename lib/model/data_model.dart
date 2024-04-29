import 'package:hive/hive.dart';

part 'data_model.g.dart';

@HiveType(typeId: 0)
class RecipeModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final List<Ingredient> ingredients;
  @HiveField(2)
  final List<String> Steps;
  @HiveField(3)
  final String categories;
  @HiveField(4)
  final String description;
  @HiveField(5)
  final String imagepath;

  RecipeModel({
    required this.name,
    required this.description,
    required this.ingredients,
    required this.Steps,
    required this.categories,
    required this.imagepath,
  });
}

@HiveType(typeId: 1)
class Ingredient {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String quantity;

  // @HiveField(2)
  // final String unit;

  Ingredient({
    required this.name,
    required this.quantity,
    // required this.unit,
  });
}

@HiveType(typeId: 2)
class Meal {
  @HiveField(0)
  final String date;
  @HiveField(1)
  final String meal;
  @HiveField(2)
  final String recipe;
  @HiveField(3)
  final String size; // Added missing semicolon
  @HiveField(4)
  final String notes;

  Meal({
    required this.date,
    required this.meal,
    required this.recipe,
    required this.size,
    required this.notes,
  });
}
