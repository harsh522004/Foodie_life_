import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/Models/Meals.dart';
import 'package:foodei_life/widgets/New_Recipe_Card.dart';
import 'package:velocity_x/velocity_x.dart';

class NewRecipes extends ConsumerStatefulWidget {
  const NewRecipes({
    super.key,
    required this.sectionTitle,
    required this.mealsList,
  });

  final List<MealModel> mealsList;
  final String sectionTitle;

  @override
  _NewRecipesState createState() => _NewRecipesState();
}

class _NewRecipesState extends ConsumerState<NewRecipes> {
  @override
  Widget build(BuildContext context) {
    final List<MealModel> recipesList = widget.mealsList;

    print("saved screen list is : $recipesList\n");

    Widget content = const Text("Loading....");
    if (recipesList.isNotEmpty) {
      content = Expanded(
        child: ListView.builder(
          itemCount: recipesList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return NewRecipeCard(
              isFullWidth: true,
              meals: recipesList[index],
            );
          },
        ),
      ).pOnly(left: 10);
    } else {
      content = Center(
        child: Image.network(
          "https://img.freepik.com/free-vector/hand-drawn-no-data-concept_52683-127818.jpg?w=1060&t=st=1718341762~exp=1718342362~hmac=4c118f94d51624ead5194b6fe72b17ecb98038ddf5eb3873c945077d5b7473e6",
        ).h(300).w(300),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.sectionTitle),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: content,
    );
  }
}
