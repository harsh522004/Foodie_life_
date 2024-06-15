import 'package:flutter/material.dart';
import 'package:foodei_life/Common/elevated_button.dart';
import 'package:foodei_life/constant/images.dart';
import 'package:foodei_life/features/auth/screens/auth.dart';
import 'package:foodei_life/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    void navigateToScreen(){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  const AuthScreen(
                  title: 'Welcome!',
                  subtitle: 'Register For Unlimited Chat!',
                  buttonLabel: 'SignUp',
                  isLoginScreen: false)));

    }
    return Scaffold(
      backgroundColor: materialColor[500],
      body: Stack(
        // Center content horizontally
        children: [
          const Positioned(
            top: 130,
            left: 70,
            child: CircleAvatar(
              radius: 35,
              //backgroundColor: materialColor[50],
              backgroundImage: AssetImage(hLandingLogo),
            ),
          ),
          Positioned(
            top: 230,
            left: 70,
            child: Text(
              'Food For \nEveryone',
              style: GoogleFonts.getFont('Mooli',
                  fontSize: 50,
                  color: materialColor[50],
                  fontWeight: FontWeight.bold,
                  height: 1),
            ),
          ),
          Positioned(
            bottom: 60,
            right: 2,
            left: 2,
            child: Image.asset(
              hLandingImage1,
              scale: 1,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 200, // Adjust the height as needed
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    materialColor[600]!.withOpacity(1.0),
                    // Fully opaque at the bottom
                    materialColor[500]!.withOpacity(0.0),
                    // Fully transparent at the top
                  ],
                  stops: const [0.7, 3.5], // Adjust the stops as needed
                ),

                color: materialColor[500]
                    ?.withOpacity(0.9), // Semi-transparent color
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 40,
            right: 40,
            child: hElevatedButton(text: 'Get Started', onTap: () => navigateToScreen()),
          ),
        ],
      ),
    );
  }
}
