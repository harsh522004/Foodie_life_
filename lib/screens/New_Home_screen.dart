import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/Models/Category_Model.dart';
import 'package:foodei_life/Models/Meals.dart';
import 'package:foodei_life/Provider/Filter_Provider.dart';
import 'package:foodei_life/Provider/Most_Popular_Recipe_provider.dart';
import 'package:foodei_life/Provider/Serch_bar_provider.dart';
import 'package:foodei_life/theme/colors.dart';
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
  List<MealModel> _mostPopularRecipes = [];

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
    _fetchMostPopularRecipes();
    setState(() {
      _initialDataLoaded = true;
    });
  }

  // fetch popular recipes
  Future<void> _fetchMostPopularRecipes() async {
    final mostPopularRecipesResult =
        await ref.read(mostPopularRecipesProvider.future);
    setState(() {
      _mostPopularRecipes = mostPopularRecipesResult;
    });
  }

  // fetch filtered recipes

  Future<void> _fetchfilteredRecipes() async {
    final mealsResult = await ref.read(filterMealsProvider.future);
    final activeFilter = ref.read(filterProvider);

    // create new list, if category selected then returns
    //recipes which belongs to that same category
    final filteredList = mealsResult.where((meal) {
      bool categoryMatch = _selectedCategory == null ||
          meal.categories.contains(_selectedCategory!.id);

      // Apply active filters
      bool filterMatch =
          (!activeFilter[FilterMap.glutenFree]! || meal.isGlutenFree) &&
              (!activeFilter[FilterMap.lactoseFree]! || meal.isLactoseFree) &&
              (!activeFilter[FilterMap.Veg]! || meal.isVegetarian) &&
              (!activeFilter[FilterMap.Vegan]! || meal.isVegan);
      return categoryMatch && filterMatch;
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

  Future<void> _handleRefresh() async {
    // Simulate network fetch or database query
    await Future.delayed(Duration(seconds: 2));
    // Update the list of items and refresh the UI
    _loadInitialData();
  }

  // build method
  @override
  Widget build(BuildContext context) {
    final mostPopularRecipesUpdated = ref.watch(mostPopularRecipesProvider);
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
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.heightBox,
              // upper part
              NewHomeAboveContent(
                searchController: _searchController,
                onFilterChanged: _fetchfilteredRecipes,
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
              SizedBox(
                  child: NewRecipesGrid(
                mealsList: _filteredRecipes,
                sectionTitle: 'Explore Recipes',
              )).h(350).w(context.screenWidth).pOnly(right: 10),

              20.heightBox,
              mostPopularRecipesUpdated.when(
                data: (recipes) => SizedBox(
                  child: NewRecipesGrid(
                    mealsList: recipes,
                    sectionTitle: 'Most Popular Recipes',
                  ),
                ).h(350).w(context.screenWidth).pOnly(right: 10),
                loading: () => Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Text('Error: $error'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
