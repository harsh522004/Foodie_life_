import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/Models/Category_Model.dart';
import 'package:foodei_life/Models/Meals.dart';
import 'package:foodei_life/Provider/Filter_Provider.dart';
import 'package:foodei_life/Provider/Serch_bar_provider.dart';
import 'package:foodei_life/theme/colors.dart';
import 'package:foodei_life/widgets/Custome_Category_card.dart';
import 'package:foodei_life/widgets/New_Category_Grid.dart';
import 'package:foodei_life/widgets/New_Recipes_Grid.dart';
import 'package:foodei_life/widgets/Side_Drawer.dart';
import 'package:foodei_life/widgets/new_home_above_content.dart';
import 'package:foodei_life/widgets/new_home_appBar.dart';
import 'package:velocity_x/velocity_x.dart';

class NewHomeScreen extends ConsumerStatefulWidget {
  const NewHomeScreen({super.key});

  @override
  _NewHomeScreenState createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends ConsumerState<NewHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKeyNew = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  bool _initialDataLoaded = false;
  CategoryModel? _selectedCategory;
  List<MealModel> _filteredRecipes = [];

  // when screen building
  @override
  void initState() {
    super.initState();

    // Load initial data for displayedCategories
    Future.delayed(Duration.zero, () {
      _loadInitialData();
    });
  }

  // load data
  void _loadInitialData() {
    ref.read(searchProvider.notifier).updateFilteredCategories('');
    _fetchfilteredRecipes();
    setState(() {
      _initialDataLoaded = true;
    });
  }

  // fetch filtered recipes

  Future<void> _fetchfilteredRecipes() async {
    final mealsResult = await ref.read(filterMealsProvider.future);

    // create new list, if category selected then returns
    //recipes which belongs to that same category
    final filteredList = mealsResult.where((meal) {
      return _selectedCategory == null ||
          meal.categories.contains(_selectedCategory!.id);
    }).toList();

    // update the filteredrecipes list
    setState(() {
      _filteredRecipes = filteredList;
    });
    // apply category if any single is selected
  }

  // trigger when user click on any category

  void _onCategorySelected(CategoryModel? category) {
    setState(() {
      if (_selectedCategory == category) {
        _selectedCategory = null;
      } else {
        _selectedCategory = category;
      }
    });

    _fetchfilteredRecipes();
  }

  // build method
  @override
  Widget build(BuildContext context) {
    // if data not avaliable then loading
    if (!_initialDataLoaded) {
      return Center(
          child: const CircularProgressIndicator(
        color: Colors.yellow,
      )); // Or any loading indicator
    }

    // scaffold
    return Scaffold(
      key: _scaffoldKeyNew,
      backgroundColor: hscreenBg,
      drawer: const SideDrawer(),
      appBar: NewHomeAppbar(
        appBar: AppBar(),
        onSideMenuTap: () {
          _scaffoldKeyNew.currentState?.openDrawer();
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.heightBox,
          // upper part
          NewHomeAboveContent(
            searchController: _searchController,
          ),
          20.heightBox,

          // category grid
          SizedBox(
              child: NewCategoryGrid(
            onCategorySelected: _onCategorySelected,
            selectedCategory: _selectedCategory,
          )).h(55).w(context.screenWidth).pOnly(right: 10),

          20.heightBox,
          // Recipes Grid
          SizedBox(child: NewRecipesGrid(mealsList: _filteredRecipes))
              .h(350)
              .w(context.screenWidth)
              .pOnly(right: 10)
        ],
      ),
    );
  }
}
