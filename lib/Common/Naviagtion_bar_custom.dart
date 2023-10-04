import 'package:flutter/material.dart';
import 'package:foodei_life/theme/colors.dart';
class NavigationButton extends StatelessWidget {
  const NavigationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.category),
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: materialColor[400],
          ),
          padding: const EdgeInsets.all(10),
          // Adjust the padding to increase button size
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.add,
                size: 30,
                color:
                materialColor[50]), // Adjust the size as needed
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.filter_list_alt),
        ),
      ],
    );
  }
}
