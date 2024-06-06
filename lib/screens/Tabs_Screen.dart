import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/theme/colors.dart';

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
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
//final availableMeal = ref.watch(filterMealsProvider);

    Widget activePage(int index) {
      switch (index) {
        case 0:
          return const HomeScreen();
        case 1:
          return const AddRecipeScreen();
        case 2:
          return const Filter();
        default:
          return Container();
      }
    }

    return Scaffold(
      extendBody: true,
      body: activePage(_selectedPageIndex),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 35),
        child: DotNavigationBar(
          backgroundColor: materialColor[50],
          enableFloatingNavBar: true,
          dotIndicatorColor: Colors.transparent,
          marginR: const EdgeInsets.only(bottom: 0, right: 40, left: 40),
          paddingR: const EdgeInsets.only(bottom: 1, top: 5),
          itemPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 13),
          currentIndex: _selectedPageIndex,
          onTap: _selectPage,
          items: <DotNavigationBarItem>[
            DotNavigationBarItem(icon: const Icon(Icons.category)),
            DotNavigationBarItem(icon: const Icon(Icons.add)),
            DotNavigationBarItem(icon: const Icon(Icons.filter_list_alt)),
          ],
        ),
      ),
    );
  }
}
