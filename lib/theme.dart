import 'package:flutter/material.dart';

class AppTheme {
  static const Color _primaryColor = Colors.blue;
  static const Color _lightBackground = Colors.white;
  static const Color _darkBackground = Colors.black;
  static const Color _buttonColor = Colors.blueAccent;

  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue, // Usa un MaterialColor como Colors.blue
      scaffoldBackgroundColor: _lightBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: _primaryColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _darkBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
