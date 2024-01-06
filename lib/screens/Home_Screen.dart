import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Models/Category_Model.dart';
import '../Provider/Filter_Provider.dart';
import '../Provider/Serch_bar_provider.dart';
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
  final TextEditingController _searchController = TextEditingController();
  bool _initialDataLoaded = false;

  @override
  void initState() {
    super.initState();

    // Load initial data for displayedCategories
    Future.delayed(Duration.zero, () {
      _loadInitialData();
    });
  }

  void _loadInitialData() {
    ref.read(searchProvider.notifier).updateFilteredCategories('');
    setState(() {
      _initialDataLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Building HomeScreen");

    if (!_initialDataLoaded) {
      // Show a loading indicator or handle the case when initial data is not loaded
      return const CircularProgressIndicator(); // Or any loading indicator
    }

    // Move the filterMealsProvider outside the build method
    //final availableMeal = ref.watch(filterMealsProvider);
    final List<CategoryModel> displayedCategories = ref.watch(searchProvider);

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
                searchController: _searchController,
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
                        itemCount: displayedCategories.length,
                        itemBuilder: (context, index) {
                          final selectedCategory = displayedCategories[index];
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
            ],
          ),
        ),
      ),
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
              .where((element) => element.categories.contains(selectedCategory.id))
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
      Navigator.pop(context); // Close the loading indicator in case of an exception
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

}
