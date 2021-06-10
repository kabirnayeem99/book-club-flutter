import 'package:flutter/material.dart';

class OurTheme {
  Color _lightGreen = Color.fromARGB(255, 213, 235, 220);
  Color _lightGrey = Color.fromARGB(255, 164, 164, 164);
  Color _darkerGrey = Color.fromARGB(255, 119, 124, 135);

  ThemeData buildTheme() {
    return ThemeData(
      canvasColor: _lightGreen,
      primaryColor: _lightGreen,
      secondaryHeaderColor: _darkerGrey,
      buttonTheme: ButtonThemeData(
          buttonColor: _darkerGrey,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          minWidth: 200.00,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          height: 40.0),
      accentIconTheme: IconThemeData(color: _lightGreen),
      accentColor: _lightGrey,
      hintColor: _lightGrey,
      colorScheme: ThemeData().colorScheme.copyWith(
            secondary: _lightGreen,
            primary: _lightGreen,
          ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: _lightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: _lightGreen),
        ),
      ),
    );
  }
}
