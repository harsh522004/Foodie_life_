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
    required this.searchController,
  });

  final TextEditingController searchController;

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
              Text(
                "Hi, $username",
                style: TextStyle(
                    fontSize: 18,
                    color: Vx.hexToColor("656565"),
                    fontWeight: FontWeight.bold),
              ),
              CustomText(),
              NewSearchBar(
                  backgroundColor: hgreyBg,
                  hintText: "Find your foodie recipes")
            ],
          ).pOnly(left: 20, right: 10);
        },
        error: (error, stackTrace) => Text('Error fetching user data: $error'),
        loading: () => const CircularProgressIndicator());
  }
}
