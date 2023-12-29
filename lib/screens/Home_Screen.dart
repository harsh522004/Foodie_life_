import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Models/Category_Model.dart';
import '../Models/Meals.dart';
import '../Provider/Filter_Provider.dart';
import '../constant/Data/dummy_data.dart';
import '../widgets/Category_Card.dart';
import '../widgets/Side_Drawer.dart';
import '../widgets/Upper_part_Home.dart';
import 'Meals_Screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    print("Building HomeScreen");

    final availableMeal = ref.watch(filterMealsProvider);
    availableMeal.when(
      data: (meals) {
        print('Available Meals: $meals');
        // Rest of the code...
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      error: (error, stack) {
        print('Error: $error');
      },
    );

    void _selectedCategory(
        BuildContext context, CategoryModel selectedCategory) {
      // Declare the filterMealsProvider variable with null
      ref.watch(filterMealsProvider).when(
        data: (meals) {
          final filteredList = meals
              .where(
                  (element) => element.categories.contains(selectedCategory.id))
              .toList();

          // Use the filterMealsProvider in the navigation
          Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => MealsScreen(
              title: selectedCategory.title,
              mealsList: filteredList,
            ),
          ));
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (error, stack) {
          // Handle error state if needed
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $error'),
              duration: const Duration(seconds: 5),
            ),
          );
        },
      );
    }

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: const SideDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Upper Part
              HomeAboveContent(
                openDrawerCallback: () {
                  _scaffoldKey.currentState!.openEndDrawer();
                },
                scaffoldKey: _scaffoldKey,
              ),

              const SizedBox(
                height: 10,
              ),
              // Middle Part (Scrollable Grid of Categories)

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: availableCategories.length,
                        itemBuilder: (context, index) {
                          final selectedCategory = availableCategories[index];
                          return CategoryCard(
                            onTap: () {
                              _selectedCategory(context, selectedCategory);
                            },
                            selectedCategory: selectedCategory,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Lower Part (Navigation Buttons)
              // const NavigationButton(),
            ],
          ),
        ),
      ),
    );
  }
}
