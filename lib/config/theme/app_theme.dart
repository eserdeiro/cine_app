import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        // appBarTheme: const AppBarTheme(
        //   systemOverlayStyle: SystemUiOverlayStyle(
        //     statusBarColor: Color(0xff1f1d2b),
        //     statusBarIconBrightness: Brightness.light,
        //   ),
        // ),
        fontFamily: 'Montserrat',

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
          onSurface: Colors.white,
        ), //
        primaryColorDark: const Color(0xff1f1d2b),
      );
}
