import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodei_life/Common/List_tile.dart';

import 'package:foodei_life/screens/New_Recipe_screen.dart';

import 'package:foodei_life/theme/colors.dart';
import 'package:foodei_life/widgets/Drawer_Clipper.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Models/Meals.dart';
import '../Provider/User_Data_Provider.dart';
import '../screens/settings.dart';

enum FetchState { loading, success, error }

class FetchResult {
  final List<MealModel> meals;
  final String error;

  FetchResult.success(this.meals) : error = '';

  FetchResult.error(this.error) : meals = [];

  // Helper methods to check the state
  bool get isSuccess => error.isEmpty;

  bool get isError => error.isNotEmpty;
}

class SideDrawer extends ConsumerWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userDataProvider);
    User? user = FirebaseAuth.instance.currentUser;

    void seetingsNavigation() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const SettingsMenu()));
    }

    Future<List<MealModel>> fetchUserRecipes(List<String> recipeIds) async {
      List<MealModel> recipes = [];

      for (String recipeId in recipeIds) {
        final recipeDoc = await FirebaseFirestore.instance
            .collection('recipes')
            .doc(recipeId)
            .get();
        if (recipeDoc.exists && recipeDoc.data() != null) {
          recipes.add(MealModel.fromFirestore(recipeDoc.data()!));
        }
      }

      return recipes;
    }

    Future<void> myRecipes(BuildContext context, String userId) async {
      final userDoc =
          await FirebaseFirestore.instance.collection('User').doc(userId).get();

      if (userDoc.exists && userDoc.data() != null) {
        List<String> myRecipes =
            List<String>.from(userDoc.data()!['myRecipes']);
        List<MealModel> recipes = await fetchUserRecipes(myRecipes);

        print("done!\n");

        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) =>
                NewRecipes(sectionTitle: "My Recipes", mealsList: recipes)));
      }
    }

    Future<void> signOut() async {
      try {
        await FirebaseAuth.instance.signOut();
        // Handle successful logout (e.g., navigate to login screen)
      } catch (e) {
        // Handle errors (e.g., show error message)
        print("Error signing out: $e");
      }
    }

    return userData.when(
      data: (data) {
        String userImage = data['imageUrl']!;
        String userName = data['username'];
        String userEmail = data['email'];
        return ClipPath(
          clipper: DrawerClipper(),
          child: Drawer(
            width: MediaQuery.sizeOf(context).width * 0.7,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  decoration: BoxDecoration(color: hyellow02),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 30, color: Vx.black),
                          ),
                          Container(child: Text(userEmail)).w(140),
                        ],
                      ).pOnly(left: 20),
                      Spacer(),
                      CircleAvatar(
                        backgroundImage: NetworkImage(userImage),
                        radius: 40,
                      ).pOnly(right: 20),
                    ],
                  ).pOnly(top: 70),
                ).h(220),
                CustomListTile(
                  icon: FontAwesomeIcons.bowlFood,
                  title: 'My Recipes',
                  onTap: () {
                    myRecipes(context, user!.uid);
                  },
                ),
                CustomListTile(
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: seetingsNavigation,
                ),
                CustomListTile(
                  icon: Icons.logout,
                  title: 'Log out',
                  onTap: signOut,
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) => Text('Error fetching user data: $error'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
