import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/Models/Meals.dart';
class FavoriteMealsNotifier extends StateNotifier<List<MealModel>>{

  // difine for work of class
  //here it is for Meals
  FavoriteMealsNotifier() : super([]);

  //Function
  //Get Meal and chek that it is favourite or not
  bool toggleMealFavoriteStatus(MealModel meal){

    //mealIsFavorite if state contains it
    final mealIsFavorite = state.contains(meal);


    //if yes the remove
    if(mealIsFavorite){
      state = state.where((element) => element.id != meal.id).toList();
      return false;
    }else{

      //if no then add meal in existing state
      state = [...state,meal];
      return true;
    }
  }// you can use this stateNotifier in provider
}
final favoriteMealsProvider = StateNotifierProvider<FavoriteMealsNotifier,List<MealModel>>((ref)  {
  return FavoriteMealsNotifier();
});