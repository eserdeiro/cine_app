import 'package:flutter/material.dart';

class AppTheme {
  

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark, 
      primary: Colors.cyan, // 
      onPrimary: Colors.cyan, 
      secondary: Color(0xff1b5663), //
      onSecondary: Colors.cyan, //
      error: Colors.red, 
      onError: Colors.red, 
      background: Color(0xff1f1d2b), //
      onBackground: Colors.cyan, //
      surface: Color(0xff1f1d2b), //
      onSurface: Colors.white), //
      primaryColorDark: Colors.red
  );
}