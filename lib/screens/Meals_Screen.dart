import 'package:flutter/material.dart';
import '../Models/Meals.dart';
import '../widgets/Meal_card.dart';
import '../theme/colors.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
      {super.key, this.title, required this.mealsList});

  final String? title;
  final List<MealModel> mealsList;


  @override
  Widget build(BuildContext context) {
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
                  ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Try selecting a different category",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
      );
    }

    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: materialColor[500],
        title: Text(title!),
      ),
      body: content,
    );
  }
}
