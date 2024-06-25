import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/Provider/Serch_bar_provider.dart';
import 'package:foodei_life/widgets/build_home_shimmer.dart';
import 'package:foodei_life/widgets/new_serch_bar.dart';
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
    final TextEditingController _searchController = TextEditingController();
    // accessing current user data contunisly
    final userData = ref.watch(userDataProvider);

    print("user data on home above content : $userData");

    return userData.when(
        data: (data) {
          String username = data['username'];
          //String userImage = data['imageUrl']!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // username text
              Text(
                "Hi, $username",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 18),
              ),

              10.heightBox,

              // title text for home
              CustomText(),

              20.heightBox,

              // search bar
              NewSearchBar(
                backgroundColor: Theme.of(context).shadowColor,
                hintText: "Find your Category",
                onFilterChanged: onFilterChanged,
                searchController: _searchController,
                onSearchQueryChanged: (String query) {
                  ref
                      .read(searchProvider.notifier)
                      .updateFilteredCategories(query);
                },
              )
            ],
          ).pOnly(left: 20, right: 10);
        },
        error: (error, stackTrace) => Text('Error fetching user data: $error'),
        loading: () => Center(child: HomeShimmer()));
  }
}
