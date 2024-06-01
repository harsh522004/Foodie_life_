import 'package:flutter/material.dart';

class HSearchBar extends StatelessWidget {
  final Color backgroundColor;
  final String hintText;
  final TextEditingController searchController;
  final void Function(String query) onSearchQueryChanged;

  const HSearchBar({
    Key? key,
    required this.backgroundColor,
    required this.hintText, required this.searchController, required this.onSearchQueryChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      onChanged: onSearchQueryChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: backgroundColor,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
      ),
    );
  }
}
