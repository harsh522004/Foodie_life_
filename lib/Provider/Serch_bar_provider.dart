import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Models/Category_Model.dart';
import '../constant/Data/dummy_data.dart';

class SearchProvider extends StateNotifier<List<CategoryModel>> {
  SearchProvider() : super([]);

  void updateFilteredCategories(String query) {
    if (query.isEmpty) {
      state = List.from(availableCategories);
    } else {
      state = availableCategories
          .where((category) =>
          category.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}

final searchProvider = StateNotifierProvider<SearchProvider, List<CategoryModel>>(
      (ref) => SearchProvider(),
);
