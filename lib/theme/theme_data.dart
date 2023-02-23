import 'package:flutter/material.dart';

const bgDark = Color(0xFF001f65);
const bgLight = Color(0xFF4853c1);
const contrast = Color(0xFFf86b18);

ThemeData defaultTheme = ThemeData(
  primaryColor: bgDark,
  colorScheme:
      ColorScheme.fromSwatch().copyWith(primary: bgLight, secondary: contrast),
  scaffoldBackgroundColor: bgLight,
  fontFamily: 'sans-serif',
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
  ),
);
