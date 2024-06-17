import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/Models/Category_Model.dart';
import 'package:foodei_life/Provider/Serch_bar_provider.dart';
import 'package:foodei_life/widgets/Custome_Category_card.dart';

class NewCategoryGrid extends ConsumerStatefulWidget {
  const NewCategoryGrid(
      {required this.selectedCategory,
      required this.onCategorySelected,
      super.key});
  final Function(CategoryModel) onCategorySelected;
  final CategoryModel? selectedCategory;

  @override
  _NewCategoryGridState createState() => _NewCategoryGridState();
}

class _NewCategoryGridState extends ConsumerState<NewCategoryGrid> {
  @override
  Widget build(BuildContext context) {
    final List<CategoryModel> displayedCategories = ref.watch(searchProvider);
    return ListView.builder(
      itemCount: displayedCategories.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final currentCategory = displayedCategories[index];

        return CustomeCategoryCard(
          selectedCategory: currentCategory,
          onTap: () {
            widget.onCategorySelected(
              currentCategory,
            );
          },
          isSelected: widget.selectedCategory == currentCategory,
        );
      },
    );
  }
}
