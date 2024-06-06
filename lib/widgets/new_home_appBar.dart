import 'package:flutter/material.dart';
import 'package:foodei_life/constant/images.dart';
import 'package:foodei_life/theme/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class NewHomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const NewHomeAppbar(
      {super.key, required this.appBar, required this.onSideMenuTap});
  final AppBar appBar;
  final VoidCallback onSideMenuTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      actions: [
        GestureDetector(
          onTap: onSideMenuTap,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: hgreyBg),
            child: Image.asset(
              hBarIcon,
            ).p(10),
          ).pOnly(left: 10).h(45),
        ),
        Spacer(),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: hcreamBg,
          ),
          child: Image.asset(
            hProfilePic,
          ),
        ).pOnly(right: 10).h(45)
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
