import 'package:flutter/material.dart';

class AppTheme {
  // Color Palette
  static const Color zenPrimary = Color(0xFF004D40);
  static const Color zenBackground = Color(0xFFFDF5E6);
  static const Color zenAccent = Color(0xFFFFB300);
  static const Color zenCardBg = Colors.white;
  
  static const Color darkPrimary = Colors.white;
  static const Color darkBackground = Colors.black;
  static const Color darkCardBg = Color(0xFF1E1E1E);
  static const Color darkAccent = Color(0xFFFFD700);

  // Zen Theme (Light)
  static ThemeData zenTheme() => ThemeData(
    brightness: Brightness.light,
    primaryColor: zenPrimary,
    scaffoldBackgroundColor: zenBackground,
    cardColor: zenCardBg,
    cardTheme: CardTheme(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: zenCardBg,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: zenPrimary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: zenAccent,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 3,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: zenPrimary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: zenPrimary, width: 2),
      ),
    ),
    dividerColor: zenAccent,
  );

  // Minimalist Theme (Dark)
  static ThemeData minimalistTheme() => ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkPrimary,
    scaffoldBackgroundColor: darkBackground,
    cardColor: darkCardBg,
    cardTheme: CardTheme(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: darkCardBg,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: darkBackground,
      foregroundColor: darkPrimary,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkAccent,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 3,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: darkPrimary, width: 2),
      ),
    ),
    dividerColor: darkAccent,
  );
}
