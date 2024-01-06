import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/Models/Category_Model.dart';
import 'package:foodei_life/Models/Meals.dart';
import 'package:foodei_life/constant/Data/dummy_data.dart';
import 'package:foodei_life/theme/colors.dart';
import 'package:foodei_life/widgets/Image_Input.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:uuid/uuid.dart';

import '../Provider/Filter_Provider.dart';

class AddRecipeScreen extends ConsumerStatefulWidget {
  const AddRecipeScreen({Key? key}) : super(key: key);

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends ConsumerState<AddRecipeScreen> {
  // Inside your function or class
  String generateUniqueId() {
    var uuid = const Uuid();
    return uuid.v4();
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _stepsController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  // Variables to store form input
  String recipeId = '';
  bool _imageUrlReceived = false;
  String _imageUrl = '';
  final CategoryModel _category = availableCategories[0];
  late List<String> _categories = [availableCategories[0].id];
  List<String> _ingredients = [];
  List<String> _steps = [];
  int _duration = 0;
  Complexity _selectedComplexity = Complexity.simple;
  Affordability _selectedAffordability = Affordability.affordable;
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;

  Future<void> addRecipeToFirestore(MealModel mealModel) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Firestore collection reference for recipes
        CollectionReference recipesCollection =
            FirebaseFirestore.instance.collection('recipes');
        String tamp = mealModel.imageUrl;

        String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
        String imageUrl = '$tamp?timestamp=$timeStamp';

        print('Adding recipe to Firestore with imageUrl: $tamp');

        // Add recipe data to Firestore
        await recipesCollection.add({
          'userId': user.uid, // Add the user ID
          'recipeId': mealModel.id,
          'categories': mealModel.categories,
          'title': mealModel.title,
          'imageUrl': imageUrl,
          'ingredients': mealModel.ingredients,
          'steps': mealModel.steps,
          'duration': mealModel.duration,
          'complexity': mealModel.complexity.toString().split('.').last,
          'affordability': mealModel.affordability.toString().split('.').last,
          'isGlutenFree': mealModel.isGlutenFree,
          'isLactoseFree': mealModel.isLactoseFree,
          'isVegan': mealModel.isVegan,
          'isVegetarian': mealModel.isVegetarian,
        });

        // Successfully added to Firestore
        print('Recipe added to Firestore successfully!');
        ref.refresh(filterMealsProvider);
      } else {
        // User not logged in
        throw Exception('User Not Logged in.');
      }
    } catch (e) {
      print("Error occur : $e");
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding recipe to Firestore: $e'),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _titleController.text = _titleController.text;
    _ingredientsController.text = _ingredients.join('\n');
    _stepsController.text = _steps.join('\n');
    _durationController.text = _duration.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Recipe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Title Input
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _titleController.text = value!;
                },
              ),

              SizedBox(height: 10),

              // Categories Dropdown
              MultiSelectDialogField<CategoryModel>(
                items: availableCategories
                    .map((category) => MultiSelectItem<CategoryModel>(
                          category,
                          category.title,
                        ))
                    .toList(),
                listType: MultiSelectListType.CHIP,
                onConfirm: (values) {
                  setState(() {
                    _categories =
                        values.map((category) => category.id).toList();
                  });
                },
              ),

              SizedBox(height: 10),

              // Ingredients Input
              TextFormField(
                controller: _ingredientsController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: 'Ingredients',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ingredients';
                  }
                  return null;
                },
                onSaved: (value) {
                  _ingredients = value!.split('\n');
                },
              ),

              SizedBox(height: 10),
              // Steps Input
              TextFormField(
                controller: _stepsController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: 'Steps',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter steps';
                  }
                  return null;
                },
                onSaved: (value) {
                  _steps = value!.split('\n');
                },
              ),
              SizedBox(height: 10),
              // Duration
              TextFormField(
                controller: _durationController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Duration (minutes)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a duration';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _duration = int.parse(value!);
                },
              ),
              SizedBox(height: 10),

              // Complexity
              DropdownButtonFormField<Complexity>(
                value: _selectedComplexity,
                onChanged: (value) {
                  setState(() {
                    _selectedComplexity = value!;
                  });
                },
                items: Complexity.values
                    .map((complexity) => DropdownMenuItem<Complexity>(
                          value: complexity,
                          child: Text(complexity.toString().split('.').last),
                        ))
                    .toList(),
                decoration: const InputDecoration(labelText: 'Complexity'),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a complexity';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              // Affordability
              DropdownButtonFormField<Affordability>(
                value: _selectedAffordability,
                onChanged: (value) {
                  setState(() {
                    _selectedAffordability = value!;
                  });
                },
                items: Affordability.values
                    .map((affordability) => DropdownMenuItem<Affordability>(
                          value: affordability,
                          child: Text(affordability.toString().split('.').last),
                        ))
                    .toList(),
                decoration: const InputDecoration(labelText: 'Affordability'),
                validator: (value) {
                  if (value == null) {
                    return 'Please select an affordability';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              // Filter Options
              CheckboxListTile(
                title: const Text('Gluten-Free'),
                value: _isGlutenFree,
                onChanged: (value) {
                  setState(() {
                    _isGlutenFree = value!;
                  });
                },
              ),
              SizedBox(height: 10),
              CheckboxListTile(
                title: const Text('Lactose-Free'),
                value: _isLactoseFree,
                onChanged: (value) {
                  setState(() {
                    _isLactoseFree = value!;
                  });
                },
              ),
              SizedBox(height: 10),
              CheckboxListTile(
                title: const Text('Vegan'),
                value: _isVegan,
                onChanged: (value) {
                  setState(() {
                    _isVegan = value!;
                  });
                },
              ),
              SizedBox(height: 10),
              CheckboxListTile(
                title: const Text('Vegetarian'),
                value: _isVegetarian,
                onChanged: (value) {
                  setState(() {
                    _isVegetarian = value!;
                  });
                },
              ),
              SizedBox(height: 10),

              // Image URL Input
              ImageInput(onPickImage: (imageUrl) {
                print('Received imageUrl: $imageUrl');
                setState(() {
                  _imageUrl = imageUrl;
                  _imageUrlReceived = true;
                });
              }),
              SizedBox(height: 10),
              // Elevated Button
              ElevatedButton(
                onPressed: () async {
                  // Validate form
                  if (_formKey.currentState!.validate()) {
                    while (!_imageUrlReceived) {
                      await Future.delayed(const Duration(milliseconds: 100));
                    }
                    // Save the recipe and update UI
                    _saveRecipe();
                  }
                },
                child: Text('Add Recipe', style: TextStyle(color: materialColor[600]),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveRecipe() async {
    if (_formKey.currentState!.validate()) {
      if (_imageUrl.isEmpty) {
        // Handle the case when imageUrl is empty
        print('Image URL is empty. Recipe not saved.');
        return;
      }

      // Wait for the imageUrl to be updated

      _formKey.currentState!.save();

      recipeId = generateUniqueId();

      print('Set Image Url is : $_imageUrl');

      final mealModel = MealModel(
        categories: _categories,
        title: _titleController.text,
        imageUrl: _imageUrl,
        ingredients: _ingredients,
        steps: _steps,
        duration: _duration,
        complexity: _selectedComplexity,
        affordability: _selectedAffordability,
        isGlutenFree: _isGlutenFree,
        isLactoseFree: _isLactoseFree,
        isVegan: _isVegan,
        isVegetarian: _isVegetarian,
        id: recipeId,
      );

      addRecipeToFirestore(mealModel);
    }
  }
}
