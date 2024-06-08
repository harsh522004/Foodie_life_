import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodei_life/Models/Meals.dart';
import 'package:foodei_life/screens/Recipe_Final.dart';
import 'package:foodei_life/widgets/Below_Meals.dart';
import 'package:transparent_image/transparent_image.dart';

class MealCard extends StatelessWidget {
  const MealCard(@required this.meals, {super.key});

  final MealModel meals;

  void selectMeal(BuildContext context, MealModel meals) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => RecipeFinal(meals)));
  }

  String get complexityText {
    return meals.complexity.name[0].toUpperCase() +
        meals.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meals.affordability.name[0].toUpperCase() +
        meals.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => {selectMeal(context, meals)},
        child: Stack(
          children: [
            Hero(
              tag: meals.id ?? '',
              child: FadeInImage(
                image: NetworkImage(meals.imageUrl),
                placeholder: MemoryImage(kTransparentImage),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.all(12),
                color: Colors.black54,
                child: Column(children: [
                  Text(
                    meals.title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Below(Icons.schedule, '${meals.duration} min'),
                      const SizedBox(
                        width: 50,
                      ),
                      Below(Icons.work, complexityText),
                      const SizedBox(
                        width: 50,
                      ),
                      Below(Icons.attach_money_rounded, affordabilityText),
                    ],
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
