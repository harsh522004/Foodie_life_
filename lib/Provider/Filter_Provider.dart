import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/Models/Meals.dart';

enum FilterMap {
  glutenFree,
  lactoseFree,
  Veg,
  Vegan,
}

class FilterNotifier extends StateNotifier<Map<FilterMap, bool>> {
  FilterNotifier()
      : super({
          FilterMap.glutenFree: false,
          FilterMap.lactoseFree: false,
          FilterMap.Veg: false,
          FilterMap.Vegan: false,
        });

  void setAllFilter(Map<FilterMap, bool> chosenFilter) {
    state = chosenFilter;
  }

  void setFilter(FilterMap filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filterProvider =
    StateNotifierProvider<FilterNotifier, Map<FilterMap, bool>>(
        (ref) => FilterNotifier());

//which return the list of filtered meals
final filterMealsProvider = FutureProvider<List<MealModel>>((ref) async {
  final activeFilter = ref.watch(filterProvider);
  try {
    QuerySnapshot querySnapshot;

    if (activeFilter.containsValue(true)) {
// If any filter is true, apply filters
      print('Applying filters: $activeFilter');

      querySnapshot = await FirebaseFirestore.instance
          .collection('recipes')
          .where('isGlutenFree', isEqualTo: activeFilter[FilterMap.glutenFree])
          .where('isLactoseFree',
              isEqualTo: activeFilter[FilterMap.lactoseFree])
          .where('isVegan', isEqualTo: activeFilter[FilterMap.Vegan])
          .where('isVegetarian', isEqualTo: activeFilter[FilterMap.Veg])
          .get();
    } else {
// If all filters are false, retrieve all recipes
      print('No filters applied. Retrieving all recipes.');
      querySnapshot =
          await FirebaseFirestore.instance.collection('recipes').get();
    }

    print('QuerySnapshot Documents:');
    for (var doc in querySnapshot.docs) {
      print(doc.data());
    }

    List<MealModel> meals = querySnapshot.docs
        .map((doc) =>
            MealModel.fromFirestore(doc.data() as Map<String, dynamic>))
        .where(
            (meal) => meal.imageUrl.startsWith('http')) // Check if URL is valid
        .toList();

    print('Fetched ${meals.length} meals from Firestore.');
    print('QuerySnapshot: $querySnapshot');

    return meals;
  } catch (e) {
    print('Error fetching meals from Firestore: $e');
    throw Exception('Error fetching meals: $e');
  }
});
