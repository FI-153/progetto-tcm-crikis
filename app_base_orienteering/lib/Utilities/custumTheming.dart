// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

var orienteeringTheme = ThemeData(
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: orienteeringGreen,
        onPrimary: orienteeringText_primary,
        secondary: orienteeringGreen,
        onSecondary: orienteeringText_primary,
        error: Colors.red,
        onError: orienteeringText_primary,
        background: Colors.white,
        onBackground: Colors.white,
        surface: Colors.white,
        onSurface: Colors.white));

const orienteeringGreen = Color.fromARGB(255, 154, 213, 186);
const orienteeringText_primary = Color.fromARGB(255, 45, 45, 45);
const orienteeringText_secondary = Color.fromARGB(128, 0, 0, 0);
const bgColorWhenPopupIsShown = Color.fromRGBO(204, 204, 204, 0.1);
const orienteeringRed = Colors.redAccent;
const clear = Color.fromARGB(0, 0, 0, 0);
const black_pale = Color.fromARGB(128, 0, 0, 0);
