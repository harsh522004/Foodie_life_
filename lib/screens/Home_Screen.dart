import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/Models/Category_Model.dart';
import 'package:foodei_life/Models/Meals.dart';
import 'package:foodei_life/screens/Meals_Screen.dart';
import 'package:foodei_life/widgets/Category_Card.dart';
import 'package:foodei_life/widgets/Side_Drawer.dart';
import 'package:foodei_life/widgets/Upper_part_Home.dart';

import '../Provider/Filter_Provider.dart';
import '../constant/Data/dummy_data.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();




  @override
  Widget build(BuildContext context) {

    // final availableMeal = ref.watch(filterMealsProvider);
    // void _selectedCategory(BuildContext context, CategoryModel selectedCategory) async {
    //   final filterMeals =
    //   Navigator.of(context).push(MaterialPageRoute(
    //     builder: (ctx) => MealsScreen(
    //       title: selectedCategory.title,
    //       mealsList: mealsList,
    //     ),
    //   ));
    // }

    print("Building HomeScreen");

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
