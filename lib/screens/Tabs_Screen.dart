import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/Models/Meals.dart';
import 'package:foodei_life/Provider/Favouirte_Meal_Provider.dart';
import 'package:foodei_life/constant/images.dart';
import 'package:foodei_life/screens/Meals_Screen.dart';
import 'package:foodei_life/screens/New_Home_screen.dart';
import 'package:foodei_life/screens/New_saved_Recipe.dart';
import 'package:foodei_life/theme/colors.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Provider/Filter_Provider.dart';
import '../widgets/set_Filter.dart';
import 'Home_Screen.dart';
import 'New_Meal_Add.dart';

const kInitialFilters = {
  FilterMap.glutenFree: false,
  FilterMap.lactoseFree: false,
  FilterMap.Veg: false,
  FilterMap.Vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  final _pageController = PageController(initialPage: 0);
  final _controller = NotchBottomBarController(index: 0);
  int maxCount = 3;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  final List<Widget> bottomBarPages = [
    NewHomeScreen(),
    AddRecipeScreen(),
    NewSavedRecipe(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              showBlurBottomBar: true,
              blurOpacity: 0.9,
              blurFilterX: 5.0,
              blurFilterY: 10.0,
              notchColor: hyellow02,
              notchBottomBarController: _controller,
              bottomBarItems: [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home_filled,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(Icons.home_filled, color: Colors.black),
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.add,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ),

                ///svg item
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.bookmark,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.bookmark,
                    color: Colors.black,
                  ),
                ),
              ],
              showLabel: false,
              onTap: (index) {
                _pageController.jumpToPage(index);
              },
              kIconSize: 25,
              kBottomRadius: 10)
          : null,
    );
  }
}
