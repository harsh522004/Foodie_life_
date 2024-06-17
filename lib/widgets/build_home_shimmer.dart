import 'package:flutter/material.dart';
import 'package:foodei_life/widgets/shimmer_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeShimmer extends StatefulWidget {
  const HomeShimmer({super.key});

  @override
  State<HomeShimmer> createState() => _HomeShimmerState();
}

class _HomeShimmerState extends State<HomeShimmer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // name
        ShimmerWidget.rectangular(height: 16, width: 85).pOnly(left: 20),
        10.heightBox,

        // title 1
        ShimmerWidget.rectangular(height: 25, width: 175).pOnly(left: 20),
        8.heightBox,

        // title 2
        ShimmerWidget.rectangular(height: 25, width: 120).pOnly(left: 20),
        10.heightBox,

        //search bar
        Row(
          children: [
            ShimmerWidget.rectangular(
              height: 54,
              width: 300,
            ),
            10.widthBox,
            ShimmerWidget.rectangular(
              height: 54,
              width: 54,
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ).pOnly(left: 20),
      ],
    );
  }
}
