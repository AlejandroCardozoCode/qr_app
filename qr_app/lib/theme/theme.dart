import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ThemeApp {
  static final Color primary = Color(0xFFedf1f4);
  //static final Color secondary = Color(0xFFD1D9E6);
  static final Color secondary = Colors.black;
  static final Color innerItemColor = Color(0xFFe2e6eb);
  static final neumorphicStyle = NeumorphicStyle(
    depth: 6,
    intensity: 0.8,
    color: ThemeApp.primary,
    boxShape: NeumorphicBoxShape.roundRect(
      BorderRadius.circular(25),
    ),
  );

  static final ThemeData light = ThemeData.light().copyWith(
    primaryColor: primary,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: primary,
        systemNavigationBarColor: primary,
        systemNavigationBarDividerColor: primary,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        )),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 5,
        shadowColor: const Color.fromARGB(56, 158, 158, 158),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: primary),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        textStyle: const TextStyle(color: Colors.white),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 5,
      shadowColor: const Color.fromARGB(56, 158, 158, 158),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}
