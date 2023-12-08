/*
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/Models/Meals.dart';

import '../Provider/Favouirte_Meal_Provider.dart';
import '../theme/colors.dart';

class RecipeFinal extends ConsumerWidget {
  const RecipeFinal(@required this.meal, {super.key});
  final MealModel meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealsList = ref.watch(favoriteMealsProvider);
    bool isSaved = mealsList.contains(meal);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: materialColor[500],
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(wasAdded
                      ? 'Meal added as a faborite'
                      : 'Meal removed successfully'),
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
                  tag: meal.id,
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
*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/Models/Meals.dart';

import '../Provider/Favouirte_Meal_Provider.dart';
import '../theme/colors.dart';

class RecipeFinal extends ConsumerWidget {
  const RecipeFinal(@required this.meal, {super.key});

  final MealModel meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealsList = ref.watch(favoriteMealsProvider);
    bool isSaved = mealsList.contains(meal);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: materialColor[500],
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(wasAdded
                      ? 'Meal added as a favorite'
                      : 'Meal removed successfully'),
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
        //shadowColor: Colors.amber,

        elevation: 5,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                materialColor[200]!,
                materialColor[300]!,
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.hardEdge,
                  shadowColor: Colors.black12,
                  elevation: 5,
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Hero(
                    tag: meal.id ?? '',
                    child: Image.network(
                      meal.imageUrl,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // title
                _buildSectionTitle(context, "Ingredients"),

                // list
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const SizedBox(height: 15),
                  for (final ingredient in meal.ingredients)
                    _buildListText(
                        context, '• $ingredient', Colors.black54, TextAlign.end),
                  const SizedBox(height: 10),
                ]),


                //title
                _buildSectionTitle(context, "Steps"),
                const SizedBox(height: 15),


                // list
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final step in meal.steps)
                      _buildListText(
                          context, step, Colors.black54, TextAlign.center),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildListText(
      BuildContext context, String text, Color textColor, TextAlign textAlign) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '-> $text',
        textAlign: textAlign,
        style:
            Theme.of(context).textTheme.titleSmall?.copyWith(color: textColor),
      ),
    );
  }
}
