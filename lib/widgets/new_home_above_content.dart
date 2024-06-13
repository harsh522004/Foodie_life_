import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/Common/new_serch_bar.dart';
import 'package:foodei_life/Common/serch_bar.dart';
import 'package:foodei_life/Provider/User_Data_Provider.dart';
import 'package:foodei_life/theme/colors.dart';
import 'package:foodei_life/widgets/cutome_text.dart';
import 'package:velocity_x/velocity_x.dart';

class NewHomeAboveContent extends ConsumerWidget {
  const NewHomeAboveContent({
    super.key,
    required this.onFilterChanged,
    required this.searchController,
  });

  final TextEditingController searchController;
  final VoidCallback onFilterChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // accessing current user data contunisly
    final userData = ref.watch(userDataProvider);
    return userData.when(
        data: (data) {
          String username = data['username'];
          String userImage = data['imageUrl']!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // username text
              Text(
                "Hi, $username",
                style: TextStyle(
                    fontSize: 18,
                    color: htextgreayColor,
                    fontWeight: FontWeight.bold),
              ),

              10.heightBox,

              // title text for home
              CustomText(),

              20.heightBox,

              // search bar
              NewSearchBar(
                backgroundColor: hgreyBg,
                hintText: "Find your foodie recipes",
                onFilterChanged: onFilterChanged,
              )
            ],
          ).pOnly(left: 20, right: 10);
        },
        error: (error, stackTrace) => Text('Error fetching user data: $error'),
        loading: () => Center(
                child: CircularProgressIndicator(
              color: hyellow02,
            )));
  }
}
