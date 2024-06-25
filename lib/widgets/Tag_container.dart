import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TagContainer extends StatelessWidget {
  const TagContainer(
      {super.key,
      required this.symbol,
      required this.tag,
      required this.bgColor});

  final IconData symbol;
  final String tag;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            symbol,
            size: 17,
            color: Colors.black,
          ),
          const SizedBox(width: 6),
          Text(
            tag,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontSize: 14),
          )
        ],
      ).pSymmetric(h: 10),
    );
  }
}
