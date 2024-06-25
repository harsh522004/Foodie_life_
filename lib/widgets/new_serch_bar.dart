import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodei_life/constant/images.dart';
import 'package:foodei_life/theme/colors.dart';
import 'package:foodei_life/widgets/New_Bottomsheet_Filter.dart';
import 'package:velocity_x/velocity_x.dart';

class NewSearchBar extends StatelessWidget {
  final Color backgroundColor;
  final String hintText;
  final VoidCallback onFilterChanged;
  final TextEditingController searchController;
  final void Function(String query) onSearchQueryChanged;

  const NewSearchBar({
    Key? key,
    required this.backgroundColor,
    required this.hintText,
    required this.onFilterChanged,
    required this.searchController,
    required this.onSearchQueryChanged, //required this.searchController, required this.onSearchQueryChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            cursorColor: hyellow02,
            controller: searchController,
            onChanged: onSearchQueryChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: backgroundColor,
              hintText: hintText,
              hintStyle: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              prefixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
            ),
          ),
        ),
        10.widthBox,
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return const newFilter();
                }).whenComplete(onFilterChanged);
          },
          child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: hyellow02,
                  ),
                  child: SvgPicture.asset(hFilterVartical)
                      .pSymmetric(v: 10, h: 10))
              .h(54),
        )
      ],
    );
  }
}
