import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodei_life/features/auth/screens/auth.dart';
import 'package:foodei_life/features/landing/landing_screen.dart';
import 'package:foodei_life/screens/Home_Screen.dart';
import 'package:foodei_life/screens/New_Home_screen.dart';

import 'package:foodei_life/screens/Tabs_Screen.dart';
import 'package:foodei_life/theme/colors.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primarySwatch: materialColor,
            primaryColor:
                materialColor // Set your materialColor as the primary color
            // Other theme configurations...
            ),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: NewHomeScreen());
    // home: StreamBuilder(
    //     stream: FirebaseAuth.instance.authStateChanges(),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         return const TabsScreen();
    //       }
    //       return const LandingScreen();
    //     }));
  }
}
