import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/Models/Meals.dart';

final mostPopularRecipesProvider = FutureProvider<List<MealModel>>((ref) async {
  // fetch Most Popular Recipes

  final snapshot = await FirebaseFirestore.instance
      .collection('recipes')
      .orderBy('viewCount', descending: true)
      .limit(10)
      .get();

  return snapshot.docs.map((doc) {
    final data = doc.data();
    return MealModel(
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
      isVegetarian: data['isVegetarian'],
      viewCount: data['viewCount'],
    );
  }).toList();
});
