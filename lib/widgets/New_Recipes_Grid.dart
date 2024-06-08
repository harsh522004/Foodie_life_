import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/Models/Meals.dart';
import 'package:foodei_life/widgets/Meal_card.dart';
import 'package:foodei_life/widgets/New_Recipe_Card.dart';
import 'package:velocity_x/velocity_x.dart';

class NewRecipesGrid extends ConsumerStatefulWidget {
  const NewRecipesGrid({
    super.key,
    required this.mealsList,
  });

  final List<MealModel> mealsList;

  @override
  _NewRecipesGridState createState() => _NewRecipesGridState();
}

class _NewRecipesGridState extends ConsumerState<NewRecipesGrid> {
  @override
  Widget build(BuildContext context) {
    final List<MealModel> recipesList = widget.mealsList;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Explore Recipes",
          style:
              Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 20),
        ),
        10.heightBox,
        Expanded(
          child: ListView.builder(
            itemCount: recipesList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return NewRecipeCard(
                meals: recipesList[index],
              );
            },
          ),
        ),
      ],
    ).pOnly(left: 10);
  }
}