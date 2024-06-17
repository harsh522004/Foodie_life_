import 'package:flutter/material.dart';
import 'package:foodei_life/Models/Category_Model.dart';
import 'package:foodei_life/theme/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomeCategoryCard extends StatelessWidget {
  const CustomeCategoryCard(
      {super.key,
      required this.selectedCategory,
      required this.onTap,
      required this.isSelected});
  final CategoryModel selectedCategory;
  final VoidCallback onTap;
  final bool isSelected;

  // selectedCategory
  // ontap
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      selectedColor: hyellow02,
      hoverColor: hyellow01,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.black),
      ),
      tileColor: isSelected ? hyellow02 : hcreamBg,
      leading: CircleAvatar(
        backgroundImage: selectedCategory.categoryImage,
      ).pOnly(bottom: 5),
      title: Text(
        selectedCategory.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ).pOnly(bottom: 5),
      selectedTileColor: hyellow02,
    ).w(150).pOnly(left: 10);
  }
}
