import 'package:flutter/material.dart';
import 'package:foodei_life/Common/serch_bar.dart';
import 'package:foodei_life/constant/images.dart';
import 'package:foodei_life/theme/colors.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:google_fonts/google_fonts.dart';
class HomeAboveContent extends StatelessWidget {



  final VoidCallback openDrawerCallback;

  const HomeAboveContent({super.key, required this.openDrawerCallback});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const GFAvatar(
              backgroundImage: AssetImage(hProfilePic),
              radius: 40,
            ),
            GestureDetector(
              onTap: openDrawerCallback, // Call _openDrawer when tapped
              child: Icon(
                Icons.notes_sharp,
                color: materialColor[500],
                size: 40,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),

        // Text title
        Container(
          padding: const EdgeInsets.only(left: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hey! Harsh',
                style: GoogleFonts.getFont(
                  'Open Sans',
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'What\'s in your Mind Today?',
                style: GoogleFonts.getFont(
                  'Open Sans',
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),

        // Sized Box
        const SizedBox(
          height: 15,
        ),

        // Search Bar
        HSearchBar(
          backgroundColor: materialColor[100]!,
          hintText: 'Search',
        ),
      ],

    );

  }
}
