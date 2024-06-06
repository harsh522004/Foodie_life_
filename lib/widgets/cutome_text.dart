import 'package:flutter/material.dart';
import 'package:foodei_life/theme/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Make your own food,\n",
        style: TextStyle(
          color: Vx.black,
          fontSize: 35,
          fontWeight: FontWeight.w900, // Extra bold
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'stay at ',
          ),
          TextSpan(
            text: 'home',
            style: TextStyle(
              color: hyellow02, // Change color for "home"
              fontWeight: FontWeight.w900, // Extra bold for "home"
            ),
          ),
        ],
      ),
    );
  }
}
