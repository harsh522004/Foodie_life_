import 'package:flutter/material.dart';
import 'package:foodei_life/Models/Category_Model.dart';
import 'package:foodei_life/Models/Meals.dart';
import 'package:foodei_life/constant/Data/dummy_data.dart';
import 'package:foodei_life/widgets/Image_Input.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({Key? key}) : super(key: key);

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

  // Variables to store form input

  String _title = '';
  String _imageUrl = '';
  final CategoryModel _category = availableCategories[0];
  List<String> _categories = [availableCategories[0].id];
  List<String> _ingredients = [];
  List<String> _steps = [];
  int _duration = 0;
  Complexity _selectedComplexity = Complexity.simple;
  Affordability _selectedAffordability = Affordability.affordable;
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;

  @override
  Widget build(BuildContext context) {
    /*Future<void> _pickImage() async {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _imageUrl = pickedFile.path;
        });
      }
    }*/

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
              // ID Input (You might want to generate this)
              /*TextFormField(
                decoration: const InputDecoration(labelText: 'ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid ID';
                  }
                  return null;
                },
                onSaved: (value) {
                  _id = value!;
                },
              ),*/

              // Title Input
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),

              // Categories Dropdown
              
              // Ingredients Input
              TextFormField(
                maxLines: null,
                // Allow multiple lines
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(labelText: 'Ingredients'),
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

              // Steps Input
              TextFormField(
                maxLines: null,
                // Allow multiple lines
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(labelText: 'Steps'),
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

              // Duration
              TextFormField(
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: 'Duration (minutes)'),
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

              // Duration Input
              TextFormField(
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: 'Duration (minutes)'),
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

              // complexity
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

              CheckboxListTile(
                title: const Text('Lactose-Free'),
                value: _isLactoseFree,
                onChanged: (value) {
                  setState(() {
                    _isLactoseFree = value!;
                  });
                },
              ),

              CheckboxListTile(
                title: const Text('Vegan'),
                value: _isVegan,
                onChanged: (value) {
                  setState(() {
                    _isVegan = value!;
                  });
                },
              ),

              CheckboxListTile(
                title: const Text('Vegetarian'),
                value: _isVegetarian,
                onChanged: (value) {
                  setState(() {
                    _isVegetarian = value!;
                  });
                },
              ),

              // Image URL Input
              ImageInput(
                onPickImage: (image) {
                  _imageUrl = image.path;
                },
              ),

              // Elevated Button
              ElevatedButton(
                onPressed: () {
                  // Validate form
                  if (_formKey.currentState!.validate()) {
                    // Save the recipe and update UI
                    _saveRecipe();
                  }
                },
                child: const Text('Add Recipe'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveRecipe() {
    final mealModel = MealModel(
        categories: _categories,
        title: _title,
        imageUrl: _imageUrl,
        ingredients: _ingredients,
        steps: _steps,
        duration: _duration,
        complexity: _selectedComplexity,
        affordability: _selectedAffordability,
        isGlutenFree: _isGlutenFree,
        isLactoseFree: _isLactoseFree,
        isVegan: _isVegan,
        isVegetarian: _isVegetarian);
    // Create a new instance of the recipe model and add it to the data source
    // Update UI to reflect the new recipe
    // Navigator.pop(context); // Navigate back to the home screen, if needed
  }
}
