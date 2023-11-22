import 'package:flutter/material.dart';
import 'package:foodei_life/Models/Category_Model.dart';


class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.onTap,
    required this.selectedCategory,
  }) : super(key: key);

  // Change the type to AssetImage
  final CategoryModel selectedCategory;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 5),
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(20), // Apply a circular border radius
        ),
        child: ClipRRect(
          // Use ClipRRect to clip the image and apply the border radius
          borderRadius: BorderRadius.circular(20),
          // Same as the outer container
          child: Stack(
            children: [
              // Background image
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: selectedCategory.categoryImage, // Use AssetImage here
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Name in the bottom right
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(7),
                  color: Colors.black.withOpacity(0.4),
                  child: Text(
                    selectedCategory.title,
                    style: const TextStyle(
                      color: Colors.white, // Set the text color to white
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
