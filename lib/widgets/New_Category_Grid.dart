import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/Models/Category_Model.dart';
import 'package:foodei_life/Provider/Filter_Provider.dart';
import 'package:foodei_life/Provider/Serch_bar_provider.dart';
import 'package:foodei_life/screens/Meals_Screen.dart';
import 'package:foodei_life/widgets/Custome_Category_card.dart';

class NewCategoryGrid extends ConsumerStatefulWidget {
  const NewCategoryGrid({super.key});

  @override
  _NewCategoryGridState createState() => _NewCategoryGridState();
}

class _NewCategoryGridState extends ConsumerState<NewCategoryGrid> {
  @override
  Widget build(BuildContext context) {
    List<CategoryModel> productList = [];
    final List<CategoryModel> displayedCategories = ref.watch(searchProvider);
    return ListView.builder(
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final selectedCategory = displayedCategories[index];
        return CustomeCategoryCard(
          selectedCategory: selectedCategory,
          onTap: () {
            _selectedCategory(context, selectedCategory);
          },
        );
      },
    );
  }

  // Move this method outside the build method
  void _selectedCategory(
    BuildContext context,
    CategoryModel selectedCategory,
  ) async {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        barrierDismissible: false,
      );

      final mealsResult = await ref.watch(filterMealsProvider);

      Navigator.pop(context); // Close the loading indicator

      mealsResult.when(
        data: (meals) {
          final filteredList = meals
              .where(
                  (element) => element.categories.contains(selectedCategory.id))
              .toList();

          Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => MealsScreen(
              title: selectedCategory.title,
              mealsList: filteredList,
            ),
          ));
        },
        loading: () {
          // This part will not be executed, as loading is already handled by the loading indicator
        },
        error: (error, stack) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $error'),
              duration: const Duration(seconds: 5),
            ),
          );
        },
      );
    } catch (error) {
      Navigator.pop(
          context); // Close the loading indicator in case of an exception
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }
}


// category selection method : 


