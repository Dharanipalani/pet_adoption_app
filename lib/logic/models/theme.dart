import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    cardColor: Colors.white,
    shadowColor: Colors.grey,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
    dialogBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    drawerTheme: const DrawerThemeData(scrimColor: Colors.white),
    dividerColor: Colors.black);

final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    cardColor: Colors.black,
    shadowColor: Colors.grey,
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
    dialogBackgroundColor: Colors.black,
    iconTheme: const IconThemeData(color: Colors.white),
    drawerTheme: const DrawerThemeData(scrimColor: Colors.black),
    dividerColor: Colors.white);
