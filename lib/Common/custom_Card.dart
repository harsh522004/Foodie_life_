import 'package:getwidget/components/card/gf_card.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.title, required this.color});

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      width: 250,
      height: 250,
      child: GFCard(

        boxFit: BoxFit.fill,
        color: color,
        elevation: 2,
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        titlePosition: GFPosition.end,
        content: Text(title),
        padding: EdgeInsets.only(top: 30),
      ),
    );
  }
}
