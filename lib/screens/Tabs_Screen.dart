import 'package:flutter/material.dart';
import 'package:foodei_life/Provider/Filter_Provider.dart';
import 'package:foodei_life/constant/Data/dummy_data.dart';
import 'package:foodei_life/screens/Home_Screen.dart';
import 'package:foodei_life/theme/colors.dart';
import 'package:foodei_life/widgets/set_Filter.dart';

const kIntialFilters = {
  FilterMap.glutenFree: false,
  FilterMap.lactoseFree: false,
  FilterMap.Veg: false,
  FilterMap.Vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const avalaibleMeal = dummyMeals;
    Widget activePage(int index) {
      switch (index) {
        case 0:
          return const HomeScreen(
            avalaibleMeal: avalaibleMeal,
          );
        case 2:
          return const Filter();
        default:
          return Container();
      }
    }

    return Scaffold(
      body: activePage(_selectPageIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectPageIndex,
        onTap: _selectPage,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        // Use fixed type to keep the buttons visible
        showSelectedLabels: false,
        // You can configure label visibility as needed
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
