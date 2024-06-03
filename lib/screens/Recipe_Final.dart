import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodei_life/Models/Meals.dart';

import '../Provider/Favouirte_Meal_Provider.dart';
import '../Provider/User_Data_Provider.dart';
import '../theme/colors.dart';

class RecipeFinal extends ConsumerWidget {
  const RecipeFinal(this.meal, {Key? key}) : super(key: key);
  final MealModel meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser!;
    bool isSaved =
        ref.watch(savedRecipesProvider.notifier).isRecipeFavorite(meal.id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          meal.title,
          style: TextStyle(fontSize: 18),
        ),
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
                    style: TextStyle(fontSize: 16),
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
                size: 28,
              ),
            ),
          ),
        ],
      ),
      body: Card(
        elevation: 5,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          //side: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(9),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                //clipBehavior: Clip.hardEdge,
                elevation: 5,
                margin: const EdgeInsets.all(5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Hero(
                  tag: meal.id ?? ' ',
                  child: Image.network(
                    meal.imageUrl,
                    width: double.infinity,
                    //height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Add Duration field
              Row(
                children: [
                  SizedBox(
                    width: 7,
                  ),
                  Icon(FontAwesomeIcons.handPointRight),
                  SizedBox(
                    width: 7,
                  ),
                  SectionTitle("Duration"),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  // '• $ingredient' //"${meal.duration} mins"
                  '• ${meal.duration} mins ',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: 7,
                  ),
                  Icon(FontAwesomeIcons.handPointRight),
                  SizedBox(
                    width: 7,
                  ),
                  SectionTitle("Ingredients"),
                ],
              ),
              const SizedBox(height: 10),
              for (final ingredient in meal.ingredients)
                IngredientItem(ingredient),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: 7,
                  ),
                  Icon(FontAwesomeIcons.handPointRight),
                  SizedBox(
                    width: 7,
                  ),
                  SectionTitle("Steps"),
                ],
              ),
              const SizedBox(height: 10),
              for (int i = 0; i < meal.steps.length; i++)
                StepItem(i + 1, meal.steps[i]),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

class IngredientItem extends StatelessWidget {
  final String ingredient;

  const IngredientItem(this.ingredient, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '• $ingredient',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

class StepItem extends StatelessWidget {
  final int stepNumber;
  final String step;

  const StepItem(this.stepNumber, this.step, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '$stepNumber. $step',
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }
}
