import 'package:flutter_riverpod/flutter_riverpod.dart';

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
final filterMealsProvider = Provider((ref) {
  final activeFilter = ref.watch(filterProvider);
  return dummyMeals.where((meal) {
    if (activeFilter[FilterMap.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }

    if (activeFilter[FilterMap.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }

    if (activeFilter[FilterMap.Veg]! && !meal.isVegetarian) {
      return false;
    }

    if (activeFilter[FilterMap.Vegan]! && !meal.isVegan) {
      return false;
    }

    return true;
  }).toList();
});
