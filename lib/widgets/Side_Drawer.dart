import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodei_life/Common/List_tile.dart';
import 'package:foodei_life/constant/images.dart';
import 'package:foodei_life/features/auth/screens/auth.dart';
import 'package:foodei_life/screens/Meals_Screen.dart';

import 'package:foodei_life/theme/colors.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/drawer/gf_drawer.dart';
import 'package:getwidget/components/drawer/gf_drawer_header.dart';

import '../Models/Meals.dart';
import '../Provider/Favouirte_Meal_Provider.dart';
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

    void savedMealsNavigation() {
      final savedMealsState = ref.watch(savedRecipesProvider);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => MealsScreen(
            mealsList: List<MealModel>.from(savedMealsState),
            title: 'Saved Meals',
          ),
        ),
      );
    }

    void seetingsNavigation() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const SettingsMenu()));
    }

    Future<void> signOut() async {
      try {
        await FirebaseAuth.instance.signOut();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => AuthScreen(
                  title: "Log In",
                  subtitle: "Log in to your account",
                  buttonLabel: "Log In",
                  isLoginScreen: true)),
          (Route<dynamic> route) => false,
        );
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
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 200,
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: materialColor[400],
                  ),
                  accountName: Text(
                    userName,
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  accountEmail: Text(userEmail),
                  currentAccountPicture: GFAvatar(
                    radius: 40.0,
                    backgroundImage: NetworkImage(userImage),
                  ),
                ),
              ),
              CustomListTile(
                icon: FontAwesomeIcons.save,
                title: 'Saved Meals',
                onTap: savedMealsNavigation,
              ),
              CustomListTile(
                icon: FontAwesomeIcons.bowlFood,
                title: 'My Recipes',
                onTap: () {},
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
        );
      },
      error: (error, stackTrace) => Text('Error fetching user data: $error'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
