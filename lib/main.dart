import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:recipe_project/model/data_model.dart';
import 'package:recipe_project/screens/about_us.dart';
import 'package:recipe_project/screens/bottom_navigation.dart';
import 'package:recipe_project/screens/privacy_policy.dart';
import 'package:recipe_project/screens/terms_condition.dart';
import 'package:recipe_project/screens/version.dart';

ValueNotifier<List<RecipeModel>> recipeListNotifier = ValueNotifier([]);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive

  // Register adapter after Hive initialization
  if (!Hive.isAdapterRegistered(RecipeModelAdapter().typeId)) {
    Hive.registerAdapter(RecipeModelAdapter());
  }
  if (!Hive.isAdapterRegistered(IngredientAdapter().typeId)) {
    Hive.registerAdapter(IngredientAdapter());
  }
  if (!Hive.isAdapterRegistered(MealAdapter().typeId)) {
    Hive.registerAdapter(MealAdapter());
  }

  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          '/about_us': (context) => AboutUsScreeen(),
          '/terms_conditions': (context) => TermsConditions(),
          '/privacy_policy': (context) => PrivacyPolicy(),
          '/version no': (context) => VersionNumber(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BottomNavigation());
  }
}
