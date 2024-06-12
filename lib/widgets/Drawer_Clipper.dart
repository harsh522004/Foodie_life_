import 'package:flutter/material.dart';

class DrawerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final Offset secondArcEndPoint = Offset(size.width - 60, 50);
    // Create path for drawer background
    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width - 60, size.height);
    path.lineTo(size.width - 60, 170);

    path.arcToPoint(
      secondArcEndPoint,
      radius: Radius.circular(10), // Adjust the radius as needed
      largeArc: true,
      clockwise: false,
    );

    path.lineTo(size.width - 60, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
