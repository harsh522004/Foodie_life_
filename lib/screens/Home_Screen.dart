import 'package:flutter/material.dart';
import 'package:foodei_life/Common/Naviagtion_bar_custom.dart';
import 'package:foodei_life/Common/custom_Card.dart';
import 'package:foodei_life/Common/serch_bar.dart';
import 'package:foodei_life/constant/images.dart';
import 'package:foodei_life/theme/colors.dart';
import 'package:foodei_life/widgets/Upper_part_Home.dart';
import 'package:foodei_life/widgets/custom_drawer.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Method to open the drawer
  void openDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeAboveContent(openDrawerCallback: openDrawer),

              // Cards
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CustomCard(
                          title: "Harsh Butani", color: materialColor[200]!),
                      CustomCard(
                          title: "Harsh Butani", color: materialColor[200]!),
                      CustomCard(
                          title: "Harsh Butani", color: materialColor[200]!),
                      CustomCard(
                          title: "Harsh Butani", color: materialColor[200]!),
                      CustomCard(
                          title: "Harsh Butani", color: materialColor[200]!),
                      // Add more CardItems as needed
                    ],
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CustomCard(
                          title: "Harsh Butani", color: materialColor[200]!),
                      CustomCard(
                          title: "Harsh Butani", color: materialColor[200]!),
                      CustomCard(
                          title: "Harsh Butani", color: materialColor[200]!),
                      CustomCard(
                          title: "Harsh Butani", color: materialColor[200]!),
                      CustomCard(
                          title: "Harsh Butani", color: materialColor[200]!),
                      // Add more CardItems as needed
                    ],
                  ),
                ),
              ),

              // Navigation Bar
              const NavigationButton(),
            ],
          ),
        ),
      ),
      endDrawer: GFDrawer(
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
                    // You can change this to any desired color
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: const EdgeInsets.only(top: 60),
              alignment: Alignment.center,
              child: const Column(
                children: [
                  GFAvatar(
                    radius: 40.0,
                    backgroundImage: AssetImage(hProfilePic),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Harsh Butani',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.save,color: Colors.black54,), // Icon for Saved Items
              title: const Text('Saved Meals'), // Text for "Saved Meals"
              onTap: () {
                // Handle the onTap action for Saved Items
                // You can add your navigation logic here
              },
            ),


            ListTile(
              leading: const  Icon(Icons.settings,color: Colors.black54,), // Icon for Settings
              title: const Text('Settings'), // Text for "Settings"
              onTap: () {
                // Handle the onTap action for Settings
                // You can add your navigation logic here
              },
            ),

            ListTile(
              leading: const Icon(Icons.logout,color: Colors.black54,), // Icon for Log Out
              title: const Text('Log Out'), // Text for "Log Out"
              onTap: () {
                // Handle the onTap action for Log Out
                // You can add your logout logic here
              },
            ),
          ],
        ),
      ),
    );
  }
}
