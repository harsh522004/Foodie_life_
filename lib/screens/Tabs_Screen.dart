import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:foodei_life/Models/Meals.dart';
import 'package:foodei_life/screens/New_Meal_Add.dart';

import '../Provider/Filter_Provider.dart';
import 'package:foodei_life/screens/Home_Screen.dart';
import '../widgets/set_Filter.dart';
import '../theme/colors.dart';

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
    final availableMeal = ref.watch(filterMealsProvider);


    Widget activePage(int index) {
      switch (index) {
        case 0:
          return HomeScreen(avalaibleMeal: availableMeal);

        case 1:
          return const AddRecipeScreen();
        case 2:
          return const Filter();
        default:
          return Container();
      }
    }

    return Scaffold(
      body: activePage(_selectedPageIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: '', // Empty label to hide text
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: materialColor[400],
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(
                Icons.add,
                size: 30,
                color: materialColor[50],
              ),
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.filter_list_alt),
            label: '',
          ),
        ],
      ),
    );
  }
}
