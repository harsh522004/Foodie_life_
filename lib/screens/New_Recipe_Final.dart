import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodei_life/Models/Meals.dart';
import 'package:foodei_life/Provider/Favouirte_Meal_Provider.dart';
import 'package:foodei_life/constant/images.dart';
import 'package:velocity_x/velocity_x.dart';

class NewRecipeFinal extends ConsumerStatefulWidget {
  const NewRecipeFinal(this.meal, {Key? key}) : super(key: key);
  final MealModel meal;

  @override
  _RecipeFinalState createState() => _RecipeFinalState();
}

class _RecipeFinalState extends ConsumerState<NewRecipeFinal> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    incrementViewCount(widget.meal.id);
  }

  void incrementViewCount(String recipeId) async {
    try {
      // Query to find the document with the specific recipeId
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('recipes')
          .where('recipeId', isEqualTo: recipeId)
          .get();

      if (querySnapshot.docs.isEmpty) {
        print("Document with recipeId $recipeId does not exist.");
        return;
      } else {
        // There should be exactly one document with the unique recipeId
        DocumentSnapshot docSnapshot = querySnapshot.docs.first;
        DocumentReference recipeRef = docSnapshot.reference;

        // Update the view count
        await recipeRef.update({'viewCount': FieldValue.increment(1)});

        print("Successfully incremented view count for recipe id: $recipeId");
      }
    } catch (e) {
      print("Error updating view count: $e");
    }
  }

  String get complexityText {
    return widget.meal.complexity.name[0].toUpperCase() +
        widget.meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return widget.meal.affordability.name[0].toUpperCase() +
        widget.meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final meal = widget.meal;
    final user = FirebaseAuth.instance.currentUser!;
    bool isSaved =
        ref.watch(savedRecipesProvider.notifier).isRecipeFavorite(meal.id);

    print(meal.isGlutenFree);
    print(meal.isLactoseFree);
    print(meal.isVegan);
    print(meal.isVegetarian);

    print(meal.ingredients);
    return Scaffold(
      body: Stack(
        children: [
          Container().h(context.screenHeight),
          Container(
            child: Hero(
              tag: meal.id ?? ' ',
              child: Image.network(
                meal.imageUrl,
                width: double.infinity,
                //height: 300,
                fit: BoxFit.cover,
              ),
            ),
          ).h(context.screenHeight * 0.5),
          Positioned(
            right: 20,
            top: 50,
            child: InkWell(
              onTap: () {
                final wasAdded = ref
                    .read(savedRecipesProvider.notifier)
                    .toggleMealFavoriteStatus(meal, user);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      wasAdded
                          ? 'recipe saved successfully'
                          : 'recipe removed successfully from saved',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.red,
                ),
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(60),
                topRight: Radius.circular(60),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.title,
                        style: TextStyle(fontSize: 27),
                      ).pOnly(top: 20, bottom: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          PropertiesSection(
                            icon: FontAwesomeIcons.clock,
                            text: meal.duration.toString() + " min.",
                          ),
                          PropertiesSection(
                            icon: Icons.tag,
                            text: complexityText,
                          ),
                          PropertiesSection(
                            icon: FontAwesomeIcons.coins,
                            text: affordabilityText,
                          ),
                        ],
                      ).pOnly(bottom: 20),

                      // icons
                      TypesIcon(
                          isVegan: meal.isVegan,
                          isVeg: meal.isVegetarian,
                          isGlutenfree: meal.isGlutenFree,
                          isLactosfree: meal.isLactoseFree),

                      10.heightBox,

                      // ingrediants
                      Text(
                        "Ingredients",
                        style: TextStyle(fontSize: 22),
                      ),

                      for (final ingredient in meal.ingredients)
                        IngredientItem(ingredient),

                      10.heightBox,

                      // steps
                      Text(
                        "Steps",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),

                      for (int i = 0; i < meal.steps.length; i++)
                        StepItem(i + 1, meal.steps[i]),
                    ],
                  ).pSymmetric(h: 20, v: 10),
                ),
              ).h(context.screenHeight * 0.56).w(context.screenWidth),
            ),
          ),
        ],
      ),
    );
  }
}

class PropertiesSection extends StatelessWidget {
  final IconData icon;
  final String text;

  const PropertiesSection({super.key, required this.icon, required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey,
        ),
        5.widthBox,
        Text(
          text,
          style: TextStyle(color: Colors.grey, fontSize: 10),
        ),
      ],
    );
  }
}

class TypesIcon extends StatelessWidget {
  final bool isVegan;
  final bool isVeg;
  final bool isGlutenfree;
  final bool isLactosfree;

  const TypesIcon(
      {super.key,
      required this.isVegan,
      required this.isVeg,
      required this.isGlutenfree,
      required this.isLactosfree});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (isVegan) TypeContainer(icon: hVeganImage, tag: "Vegan"),
          if (isVeg) TypeContainer(icon: hVegImage, tag: "Vegeterian"),
          if (isGlutenfree)
            TypeContainer(icon: hGlutenImage, tag: "GlutenFree"),
          if (isLactosfree)
            TypeContainer(icon: hLactoseImage, tag: "LactosFree"),
        ],
      ),
    ).w(context.screenWidth);
  }
}

class TypeContainer extends StatelessWidget {
  final String icon;
  final String tag;

  const TypeContainer({super.key, required this.icon, required this.tag});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Vx.hexToColor("dcf2e6"),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
            child: Image.asset(
              icon,
              fit: BoxFit.cover,
            ),
          ).h(40).w(40).pOnly(top: 8),
          Text(
            tag,
            style:
                Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 8),
          ).pOnly(top: 8),
        ],
      ),
    ).w(75).h(75);
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
    print("ingrdient called .... ");
    return Row(
      children: [
        Container(
          child: Image.asset(
            hBulletIcon,
            fit: BoxFit.cover,
          ),
        ).h(25).w(25),
        Text("$ingredient").pOnly(left: 20),
      ],
    ).pSymmetric(v: 10, h: 28);
  }
}

class StepItem extends StatelessWidget {
  final int stepNumber;
  final String step;

  const StepItem(this.stepNumber, this.step, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Vx.hexToColor("9bd8bb"),
                  width: 2.0, // You can adjust the width of the border here
                ),
              ),
            ),
            child: Text(
              stepNumber.toString(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ).h(40).w(25),
          20.widthBox,
          Expanded(
            child: Text(
              step,
            ),
          ),
        ],
      ),
    ).pSymmetric(v: 10, h: 28);
  }
}
