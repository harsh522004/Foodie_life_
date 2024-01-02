import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/Common/List_tile.dart';
import 'package:foodei_life/screens/Meals_Screen.dart';

import 'package:foodei_life/theme/colors.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/drawer/gf_drawer.dart';

import '../Models/Meals.dart';
import '../Provider/Favouirte_Meal_Provider.dart';
import '../Provider/User_Data_Provider.dart';
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
    return userData.when(
      data: (data) {
        String userImage = data['imageUrl']!;
        String userName = data['username'];
        return GFDrawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      materialColor[500]!,
                      materialColor[400]!,
                      materialColor[300]!,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                padding: const EdgeInsets.only(top: 60),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    GFAvatar(
                      radius: 40.0,
                      backgroundImage: NetworkImage(userImage),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              CustomListTile(
                icon: Icons.save,
                title: 'Saved Meals',
                onTap: savedMealsNavigation,
              ),
              CustomListTile(
                icon: Icons.restaurant,
                title: 'My Recipes',
                onTap: () {},
              ),
              CustomListTile(
                icon: Icons.logout,
                title: 'Log out',
                onTap: () {},
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
