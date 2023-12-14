import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/Models/Meals.dart';

final mealsProvider = StateNotifierProvider<MealsNotifier, List<MealModel>>(
      (ref) => MealsNotifier()..fetchRecipesFromFirestore(),
);

class MealsNotifier extends StateNotifier<List<MealModel>> {
  MealsNotifier() : super([]);

  Future<void> fetchRecipesFromFirestore() async {
    try {
      // Fetch recipes from Firestore
      // You should replace 'recipes' with the actual collection name
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('recipes').get();

      // Convert Firestore data to a list of MealModel
      List<MealModel> recipes = querySnapshot.docs
          .map((doc) => MealModel.fromFirestore(doc.data()))
          .toList();

      // Update state with fetched recipes
      state = recipes;
    } catch (e) {
      // Handle errors
      print('Error fetching recipes: $e');
    }
  }

// Other functions, if needed...
}
