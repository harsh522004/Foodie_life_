import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodei_life/Models/Meals.dart';
import 'package:foodei_life/screens/New_Recipe_Final.dart';
import 'package:foodei_life/theme/colors.dart';
import 'package:foodei_life/widgets/Tag_container.dart';
import 'package:velocity_x/velocity_x.dart';

class NewRecipeCard extends StatelessWidget {
  const NewRecipeCard(
      {super.key, required this.meals, required this.isFullWidth});

  final MealModel meals;
  final bool isFullWidth;

  void selectMeal(BuildContext context, MealModel meals) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => NewRecipeFinal(meals)));
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
    return GestureDetector(
      onTap: () => selectMeal(context, meals),
      child: Stack(
        children: [
          Container(
            width: isFullWidth ? context.screenWidth : 310,
            child: Image.network(
              meals.imageUrl,
              fit: BoxFit.cover, // Ensures the image covers the container
            ).cornerRadius(20),
          ).h(300),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0, // Centers the inner container horizontally
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14), color: Vx.white),
              child: Center(
                // Centers the text within the inner container
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    Text(
                      meals.title,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      softWrap: true,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                    ),

                    // Time
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.clock,
                          size: 17,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${meals.duration} min',
                          style: TextStyle(color: htextgreayColor),
                        )
                      ],
                    ),

                    //Spacer(),
                    10.heightBox,

                    // New Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // complexity
                        TagContainer(
                          symbol: Icons.access_alarms_outlined,
                          tag: affordabilityText,
                          bgColor: Vx.hexToColor("f7e8c5"),
                        ),

                        // affordoble
                        TagContainer(
                          symbol: Icons.baby_changing_station_sharp,
                          tag: complexityText,
                          bgColor: Vx.hexToColor("a2bced"),
                        ),
                      ],
                    ).pOnly(bottom: 10),
                  ],
                ).pSymmetric(h: 10),
              ),
            ).h(120).centered().pSymmetric(h: 10),
          ),
        ],
      ).pOnly(right: 20),
    );
  }
}
