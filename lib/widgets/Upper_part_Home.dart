import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/Provider/Serch_bar_provider.dart';

import '../Common/serch_bar.dart';
import 'package:foodei_life/Provider/User_Data_Provider.dart';

import '../theme/colors.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAboveContent extends ConsumerWidget {
  final VoidCallback openDrawerCallback;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final TextEditingController searchController;

  const HomeAboveContent(
      {super.key,
      required this.scaffoldKey,
      required this.searchController,
      required this.openDrawerCallback});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userDataProvider);

    return userData.when(
        data: (data) {
          if (data != null) {
            String username = data['username'];
            String userImage = data['imageUrl']!;

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GFAvatar(
                      backgroundImage: NetworkImage(userImage),
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
                        'Hey! $username',
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
                    searchController: searchController,
                    onSearchQueryChanged: (String query) {
                      ref
                          .read(searchProvider.notifier)
                          .updateFilteredCategories(query);
                    }),
              ],
            );
          } else {
            return const Text(
                'Data is null'); // Handle the case where data is null
          }
        },
        error: (error, stackTrace) => Text('Error fetching user data: $error'),
        loading: () => const CircularProgressIndicator());
  }
}
