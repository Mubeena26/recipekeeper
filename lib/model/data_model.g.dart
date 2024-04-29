// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeModelAdapter extends TypeAdapter<RecipeModel> {
  @override
  final int typeId = 0;

  @override
  RecipeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipeModel(
      name: fields[0] as String,
      description: fields[4] as String,
      ingredients: (fields[1] as List).cast<Ingredient>(),
      Steps: (fields[2] as List).cast<String>(),
      categories: fields[3] as String,
      imagepath: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RecipeModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.ingredients)
      ..writeByte(2)
      ..write(obj.Steps)
      ..writeByte(3)
      ..write(obj.categories)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.imagepath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class IngredientAdapter extends TypeAdapter<Ingredient> {
  @override
  final int typeId = 1;

  @override
  Ingredient read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ingredient(
      name: fields[0] as String,
      quantity: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Ingredient obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IngredientAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MealAdapter extends TypeAdapter<Meal> {
  @override
  final int typeId = 2;

  @override
  Meal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Meal(
      date: fields[0] as String,
      meal: fields[1] as String,
      recipe: fields[2] as String,
      size: fields[3] as String,
      notes: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Meal obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.meal)
      ..writeByte(2)
      ..write(obj.recipe)
      ..writeByte(3)
      ..write(obj.size)
      ..writeByte(4)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
