import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  scaffoldBackgroundColor: const Color(0xFF001A23),
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF001A23)),
  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: const Color(0xFFD2F1E4),
    backgroundColor: const Color.fromARGB(209, 0, 26, 35).withOpacity(0.9)),
  iconTheme: const IconThemeData(
    color: Color.fromARGB(125, 158, 158, 158)
  ),
  primaryIconTheme: const IconThemeData(
    color: Color.fromRGBO(245, 245, 221, 1),
  ),
  colorScheme: const ColorScheme.dark(
    background: Color(0xFF001A23),
    primary: Color(0x8053917E),
    secondary: Color(0xFFD2F1E4),
    tertiary: Color.fromARGB(125, 158, 158, 158),
  ),
  textTheme: ThemeData.dark().textTheme.apply(
    displayColor: const Color.fromRGBO(245, 245, 221, 1),
    bodyColor: const Color.fromRGBO(245, 245, 221, 1),
)
);