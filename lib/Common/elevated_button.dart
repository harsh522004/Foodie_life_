import 'package:flutter/material.dart';
import 'package:foodei_life/theme/colors.dart';

class hElevatedButton extends StatelessWidget {
  hElevatedButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size( 1 , 50),

        backgroundColor: materialColor[50],
        // Set button background to transparent
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        padding: EdgeInsets.zero, // Remove default padding
      ),
      child: Container(
        alignment: Alignment.center,
        child: Text(
          text,
          style:  TextStyle(color: materialColor[500],
        ),
      ),
    ),
    );
  }
}
