import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rezepte_moedling/repositories/recipe_repository.dart';
import 'repositories/local_recipe_repository.dart';
import 'screens/details_screen.dart';

import 'models/recipe.dart';
import 'screens/add_recipe_screen.dart';
import 'screens/edit_recipe_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<RecipeRepository>(
      create: (context) => LocalRecipeRepository(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Meine Rezepte',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        //home: const MyHomePage(title: 'Meine Lieblingsrezepte'),
        initialRoute: "/",
        routes: {
          '/': (context) => const HomeScreen(),
          '/recipe_detail': (context) => DetailsScreen(
              recipe: ModalRoute.of(context)!.settings.arguments as Recipe),
          '/add_recipe': (context) => const AddRecipeScreen(),
          '/edit_recipe': (context) => EditRecipeScreen(
              recipe: ModalRoute.of(context)!.settings.arguments as Recipe),
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
