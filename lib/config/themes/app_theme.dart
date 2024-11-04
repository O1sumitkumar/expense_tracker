import 'package:flutter/material.dart';

// Define color constants for better maintainability
const Color primaryColor = Colors.red;
const Color secondaryColor = Colors.pink;
const Color lightTextColor = Colors.black;
const Color darkTextColor = Colors.white;

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    double baseFontSize = MediaQuery.of(context).size.width < 600 ? 14 : 16;

    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(0xFFFF0000, <int, Color>{
        50: Colors.red[50]!,
        100: Colors.red[100]!,
        200: Colors.red[200]!,
        300: Colors.red[300]!,
        400: Colors.red[400]!,
        500: Colors.red[500]!,
        600: Colors.red[600]!,
        700: Colors.red[700]!,
        800: Colors.red[800]!,
        900: Colors.red[900]!,
      })).copyWith(secondary: secondaryColor),
      textTheme: _lightTextTheme(baseFontSize),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      inputDecorationTheme: _inputDecorationTheme(),
      elevatedButtonTheme: _buttonTheme(),
      outlinedButtonTheme: _outlinedButtonTheme(),
      textButtonTheme: _textButtonTheme(),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.red,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black54,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardTheme(
        color: Colors.red.withOpacity(0.5),
        elevation: 5,
      ),
      dialogTheme: const DialogTheme(
        backgroundColor: Colors.red,
        titleTextStyle: TextStyle(color: Colors.white),
        contentTextStyle: TextStyle(color: Colors.white),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Colors.red,
        contentTextStyle: TextStyle(color: Colors.white),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.white,
      ),
      useMaterial3: true,
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    double baseFontSize = MediaQuery.of(context).size.width < 600 ? 14 : 16;

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
      ),
      textTheme: _darkTextTheme(baseFontSize),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      inputDecorationTheme: _inputDecorationTheme(),
      elevatedButtonTheme: _buttonTheme(),
      outlinedButtonTheme: _outlinedButtonTheme(),
      textButtonTheme: _darkTextButtonTheme(),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.pink,
        foregroundColor: Colors.black,
      ),
      cardTheme: CardTheme(
        color: Colors.red.withOpacity(0.5),
        elevation: 5,
      ),
      dialogTheme: const DialogTheme(
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(color: Colors.white),
        contentTextStyle: TextStyle(color: Colors.white),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Colors.pink,
        contentTextStyle: TextStyle(color: Colors.black),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.pink,
      ),
      useMaterial3: true,
    );
  }

  static TextTheme _lightTextTheme(double baseFontSize) {
    return TextTheme(
      headlineLarge: TextStyle(
        fontSize: baseFontSize * 2.4,
        color: lightTextColor,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
          fontSize: baseFontSize * 1.3,
          color: lightTextColor,
          letterSpacing: baseFontSize * 0.01),
      bodyMedium: TextStyle(fontSize: baseFontSize, color: Colors.black54),
      bodySmall:
          TextStyle(fontSize: baseFontSize * 0.875, color: Colors.black54),
      labelLarge:
          TextStyle(fontSize: baseFontSize * 1.125, color: Colors.white),
      labelMedium: TextStyle(fontSize: baseFontSize, color: Colors.black),
      labelSmall:
          TextStyle(fontSize: baseFontSize * 0.875, color: Colors.black),
      titleLarge: TextStyle(fontSize: baseFontSize * 1.25, color: Colors.black),
      titleMedium:
          TextStyle(fontSize: baseFontSize * 1.125, color: Colors.black),
      titleSmall: TextStyle(fontSize: baseFontSize, color: Colors.black),
    );
  }

  static TextTheme _darkTextTheme(double baseFontSize) {
    return TextTheme(
      headlineLarge: TextStyle(
        fontSize: baseFontSize * 2.4,
        color: darkTextColor,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        fontSize: baseFontSize * 1.3,
        color: darkTextColor,
        letterSpacing: baseFontSize * 0.01,
      ),
      bodyMedium: TextStyle(fontSize: baseFontSize, color: Colors.white54),
      bodySmall:
          TextStyle(fontSize: baseFontSize * 0.875, color: Colors.white54),
      labelLarge:
          TextStyle(fontSize: baseFontSize * 1.125, color: Colors.white),
      labelMedium: TextStyle(fontSize: baseFontSize, color: Colors.white54),
      labelSmall:
          TextStyle(fontSize: baseFontSize * 0.875, color: Colors.white54),
      titleLarge: TextStyle(fontSize: baseFontSize * 1.25, color: Colors.white),
      titleMedium:
          TextStyle(fontSize: baseFontSize * 1.125, color: Colors.white),
      titleSmall: TextStyle(fontSize: baseFontSize, color: Colors.white),
    );
  }

  static InputDecorationTheme _inputDecorationTheme() {
    return InputDecorationTheme(
      border: OutlineInputBorder(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      isDense: true,
      errorStyle: const TextStyle(
        color: Colors.red,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(8.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[500]!),
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(8.0),
      ),
      suffixIconColor: Colors.pink,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pink),
        borderRadius: BorderRadius.circular(8.0),
        // gapPadding: 10,
      ),
    );
  }

  static ElevatedButtonThemeData _buttonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  static OutlinedButtonThemeData _outlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.red,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        side: BorderSide(color: Colors.red),
      ),
    );
  }

  static TextButtonThemeData _textButtonTheme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.red,
      ),
    );
  }

  static TextButtonThemeData _darkTextButtonTheme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
    );
  }

  // status bar background color
  static Color _statusBarColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.white;
  }
}
