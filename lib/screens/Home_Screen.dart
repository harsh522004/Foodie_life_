import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodei_life/Models/Category_Model.dart';


// Import your search bar widget
import '../Models/Meals.dart';

import './Meals_Screen.dart';
import '../widgets/Side_Drawer.dart';
import '../widgets/Upper_part_Home.dart';
import '../widgets/Category_Card.dart';

import '../constant/Data/dummy_data.dart';

// Import your NavigationButton widget

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.avalaibleMeal});

  final List<MealModel> avalaibleMeal;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _selectedCategory(BuildContext context, CategoryModel selectedCategory) {
    final filterMeals = widget.avalaibleMeal
        .where((meal) => meal.categories.contains(selectedCategory.id))
        .toList();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealsScreen(
              title: selectedCategory.title,
              mealsList: filterMeals,
            )));
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

                  // Define the logic to open the sidebar here
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
                          crossAxisCount: 2, // 2 columns
                          crossAxisSpacing: 16.0, // Add horizontal spacing
                          mainAxisSpacing: 16.0,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,

                        // List of categories in Data
                        itemCount: availableCategories.length,
                        itemBuilder: (context, index) {
                          final selectedCategory = availableCategories[index];
                          return CategoryCard(
                              onTap: () {
                                _selectedCategory(context, selectedCategory);
                              },
                              selectedCategory: selectedCategory);
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Lower Part (Navigation Buttons)
              //const NavigationButton(),
            ],
          ),
        ),
        //),
      ),
    );
  }
}
