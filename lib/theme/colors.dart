import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

MaterialColor materialColor = MaterialColor(0xFFEFB31A, {
  50: Color(0xFFFFFCF4),
  100: Color(0xFFFEF8E9),
  200: Color(0xFFFBECC6),
  300: Color(0xFFF9E0A2),
  400: Color(0xFFF4CA5F),
  500: Color(0xFFEFB31A),
  600: Color(0xFFD5A018),
  700: Color(0xFF906C10),
  800: Color(0xFF6C510C),
  900: Color(0xFF463408),
});

// primary color
Color hyellow01 = Vx.hexToColor("f3d738");
Color hyellow02 = Vx.hexToColor("efb31a");

// light Theme
Color hscreenBg = Vx.hexToColor("fefffa"); //"f5f5f5"); // "fffbe6"
Color hgreyBg = Vx.hexToColor("ececec");
Color hcreamBg = Vx.hexToColor("e9e1ce");
Color htextgreayColor = Vx.hexToColor("656565");

class MyTheme {
  static ThemeData lightTheme = ThemeData(
    textTheme: TextTheme(
      // black text
      displaySmall: TextStyle(color: Colors.black),

      // grey text
      titleMedium: TextStyle(color: Vx.hexToColor("696b68")),

      // card title
      bodyLarge: TextStyle(color: Colors.black),
    ),
    iconTheme: IconThemeData(
      color: Colors.blueGrey,
    ),
    scaffoldBackgroundColor: Vx.hexToColor("f4f6f3"),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: Colors.white),
    canvasColor: Vx.hexToColor("ffffff"),
    cardColor: Vx.hexToColor("e9e1ce"),
    shadowColor: Vx.hexToColor("ececec"),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TextTheme(
      // black text
      displaySmall: TextStyle(color: Colors.black),

      // grey text
      titleMedium: TextStyle(color: Vx.hexToColor("696b68")),

      // card title
      bodyLarge: TextStyle(color: Colors.white),
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    scaffoldBackgroundColor: Vx.hexToColor("1e1e1e"),
    shadowColor: Vx.hexToColor("373737"),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: Vx.hexToColor("2d2d2d")),
    canvasColor: Vx.hexToColor("2d2d2d"),
    cardColor: Vx.hexToColor("e9e1ce"),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Vx.hexToColor("595959"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
