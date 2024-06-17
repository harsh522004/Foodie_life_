import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/Models/Meals.dart';
import 'package:foodei_life/Provider/Favouirte_Meal_Provider.dart';
import 'package:foodei_life/screens/New_Recipe_screen.dart';


class NewSavedRecipe extends ConsumerWidget {
  const NewSavedRecipe({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("saved Recipes screen called \n");
    final savedMealsState = ref.watch(savedRecipesProvider);

    return NewRecipes(
        sectionTitle: "Your Favourite Recipes",
        mealsList: List<MealModel>.from(savedMealsState));
  }
}
