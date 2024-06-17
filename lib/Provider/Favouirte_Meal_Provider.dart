import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/Models/Meals.dart';

class SavedRecipesProvider extends StateNotifier<List<MealModel>> {
  SavedRecipesProvider() : super([]);

  // Function to check if a recipe is already saved as a favorite
  bool isRecipeFavorite(String recipeId) {
    return state.any((meal) => meal.id == recipeId);
  }

  bool toggleMealFavoriteStatus(MealModel meal, User user) {
    final mealIsFavorite = state.contains(meal);
    if (mealIsFavorite) {
      removeRecipeFromFavorites(meal, user);
      return false;
    } else {
      addRecipeToFavorites(meal, user);
      return true;
    }
  }

  // Function to add a recipe to the saved recipes list
  void addRecipeToFavorites(MealModel meal, User user) {
    state = [...state, meal];
    updateSavedRecipesInUserDocument(
        state.map((meal) => meal.id).toList(), user);
  }

  // Function to remove a recipe from the saved recipes list
  void removeRecipeFromFavorites(MealModel meal, User user) {
    state = state.where((element) => element.id != meal.id).toList();
    updateSavedRecipesInUserDocument(
        state.map((meal) => meal.id).toList(), user);
  }

  // Function to update saved recipes in user document
  void updateSavedRecipesInUserDocument(
      List<String> savedRecipeIds, User user) async {
    await FirebaseFirestore.instance.collection('User').doc(user.uid).update({
      'savedRecipes': savedRecipeIds,
    });

    print('Saved recipes updated successfully. Recipe IDs: $savedRecipeIds');
  }

  // Function to fetch saved recipes from Firestore based on user data
  Future<void> fetchSavedRecipes(User user) async {
    try {
      final userData = await FirebaseFirestore.instance
          .collection('User')
          .doc(user.uid)
          .get();
      final List<String> savedRecipeIds =
          List<String>.from(userData['savedRecipes'] ?? []);

      final snapshot = await FirebaseFirestore.instance
          .collection('recipes')
          .where('recipeId', whereIn: savedRecipeIds)
          .get();

      final savedMeals = snapshot.docs.map((doc) {
        final data = doc.data();
        return MealModel(
// Map your fields accordingly
          id: data['recipeId'],
          title: data['title'],
          imageUrl: data['imageUrl'],
          categories: List<String>.from(data['categories']),
          ingredients: List<String>.from(data['ingredients']),
          steps: List<String>.from(data['steps']),
          duration: data['duration'],
          complexity: Complexity.values.firstWhere(
              (e) => e.toString().split('.').last == data['complexity']),
          affordability: Affordability.values.firstWhere(
              (e) => e.toString().split('.').last == data['affordability']),
          isGlutenFree: data['isGlutenFree'],
          isLactoseFree: data['isLactoseFree'],
          isVegan: data['isVegan'],
          isVegetarian: data['isVegetarian'], viewCount: 0,
        );
      }).toList();

      state = savedMeals;
    } catch (error) {
      print('Error fetching saved recipes: $error');
    }
  }
}

final savedRecipesProvider =
    StateNotifierProvider<SavedRecipesProvider, List<MealModel>>((ref) {
  return SavedRecipesProvider();
});
