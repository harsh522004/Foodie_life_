import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/Models/Meals.dart';

import '../constant/Data/dummy_data.dart';

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
final filterMealsProvider = Provider((ref) async {
  final activeFilter = ref.watch(filterProvider);
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('recipes')
        .where('isGlutenFree', isEqualTo: activeFilter[FilterMap.glutenFree])
        .where('isLactoseFree', isEqualTo: activeFilter[FilterMap.lactoseFree])
        .where('isVegan', isEqualTo: activeFilter[FilterMap.Vegan])
        .where('isVegetarian', isEqualTo: activeFilter[FilterMap.Veg]).get();

    List<MealModel> meals = querySnapshot.docs
    .map((doc) => MealModel.fromFirestore(doc.data() as Map<String, dynamic>) )
        .toList();

    return meals;


    }catch(e){
    print('Error fetching meals from Firestore: $e');
    return [];

    }
        // return dummyMeals.where((meal) {
        //   if (activeFilter[FilterMap.glutenFree]! && !meal.isGlutenFree) {
        //     return false;
        //   }
        //
        //   if (activeFilter[FilterMap.lactoseFree]! && !meal.isLactoseFree) {
        //     return false;
        //   }
        //
        //   if (activeFilter[FilterMap.Veg]! && !meal.isVegetarian) {
        //     return false;
        //   }
        //
        //   if (activeFilter[FilterMap.Vegan]! && !meal.isVegan) {
        //     return false;
        //   }
        //
        //   return true;
        // }).toList();
    });