import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/Models/Meals.dart';

import '../Provider/Favouirte_Meal_Provider.dart';
import '../Provider/User_Data_Provider.dart';
import '../theme/colors.dart';

class RecipeFinal extends ConsumerWidget {
  const RecipeFinal(@required this.meal, {super.key});
  final MealModel meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /*final mealsList = ref.watch(favoriteMealsProvider);
    final user = FirebaseAuth.instance.currentUser! ;
    bool isSaved = mealsList.contains(meal);*/
    final user = FirebaseAuth.instance.currentUser! ;
    bool isSaved = ref.watch(savedRecipesProvider.notifier).isRecipeFavorite(meal.id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: materialColor[500],
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(savedRecipesProvider.notifier)
                  .toggleMealFavoriteStatus(meal, user);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    wasAdded
                        ? 'Meal added as a favorite'
                        : 'Meal removed successfully',
                  ),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: animation,
                  child: child,
                );
              },
              child: Icon(
                isSaved ? Icons.star : Icons.star_border_outlined,
                key: ValueKey(isSaved),
              ),
            ),
          ),
        ],
      ),
      body: Card(
        shadowColor: Colors.amber,
        elevation: 5,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(9)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                clipBehavior: Clip.hardEdge,
                shadowColor: Colors.amber,
                elevation: 5,
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.amber),
                    borderRadius: BorderRadius.circular(9)),
                child: Hero(
                  tag: meal.id ?? ' ',
                  child: Image.network(
                    meal.imageUrl,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Ingredient",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.yellow, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              for (final ingredients in meal.ingredients)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ingredients,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Steps",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.yellow, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              for (final steps in meal.steps)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    steps,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: Colors.black54),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
