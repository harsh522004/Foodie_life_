import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/Models/Meals.dart';
import 'package:foodei_life/Provider/Favouirte_Meal_Provider.dart';
import 'package:foodei_life/widgets/Meal_card.dart';

class NewSavedRecipe extends ConsumerWidget {
  const NewSavedRecipe({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("saved Recipes screen called \n");
    final savedMealsState = ref.watch(savedRecipesProvider);
    final List<MealModel> mealsList = savedMealsState;

    Widget content = const Text("hii");
    if (mealsList.isNotEmpty) {
      content = ListView.builder(
        itemCount: mealsList.length,
        itemBuilder: (ctx, index) => MealCard(mealsList[index]),
      );
    }

    if (mealsList.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Uh oh ..... nothing here!",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Try selecting a different category",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: content,
    );
  }
}
