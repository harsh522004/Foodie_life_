import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:foodei_life/screens/New_Home_screen.dart';
import 'package:foodei_life/screens/New_saved_Recipe.dart';
import 'package:foodei_life/theme/colors.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Provider/Filter_Provider.dart';
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
              color:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor ??
                      Colors.white,
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
                    color: Theme.of(context).iconTheme.color,
                  ),
                  activeItem:
                      Icon(Icons.home_filled, color: Vx.hexToColor("2d2d2d")),
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.add,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  activeItem: Icon(
                    Icons.add,
                    color: Vx.hexToColor("2d2d2d"),
                  ),
                ),

                ///svg item
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.bookmark,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  activeItem: Icon(
                    Icons.bookmark,
                    color: Vx.hexToColor("2d2d2d"),
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
