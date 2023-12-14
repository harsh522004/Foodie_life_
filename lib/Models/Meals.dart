import 'package:flutter/material.dart';

enum Complexity {
  simple,
  challenging,
  hard,
}

enum Affordability {
  affordable,
  pricey,
  luxurious,
}

class MealModel {
  const MealModel({
    this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });

  final String? id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;
  factory MealModel.fromFirestore(Map<String, dynamic> data) {
    return MealModel(
      id: data['id'],
      categories: List<String>.from(data['categories']),
      title: data['title'],
      imageUrl: data['imageUrl'],
      ingredients: List<String>.from(data['ingredients']),
      steps: List<String>.from(data['steps']),
      duration: data['duration'],
      complexity: Complexity.values.firstWhere(
            (e) => e.toString() == 'Complexity.${data['complexity']}',
      ),
      affordability: Affordability.values.firstWhere(
            (e) => e.toString() == 'Affordability.${data['affordability']}',
      ),
      isGlutenFree: data['isGlutenFree'],
      isLactoseFree: data['isLactoseFree'],
      isVegan: data['isVegan'],
      isVegetarian: data['isVegetarian'],
    );
  }


}
