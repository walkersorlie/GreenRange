import 'package:flutter/material.dart';


class BaseTheme {
  static const _swatch = const MaterialColor(0xff4c5b3c,
      const {
        50: const Color(0xffeef4ea),
        100: const Color(0xffd7e4cd),
        200: const Color(0xffbed4ae),
        300: const Color(0xffa7c48f),
        400: const Color(0xff96b879),
        500: const Color(0xff87ac63),
        600: const Color(0xff7b9d5a),
        700: const Color(0xff6e8b50),
        800: const Color(0xff627a49),
        900: const Color(0xff4c5b3c)
      }
  );
  static const _primaryColor = Color(0xff4c5b3c);
  static const _accentColor = Color(0xffe6e0d8);

  static final ThemeData baseTheme = ThemeData(
    primarySwatch: _swatch,
    primaryColor: _primaryColor,
    accentColor: _accentColor,
    elevatedButtonTheme: ElevatedButtonThemeData(style: _elevatedButtonStyle),
    floatingActionButtonTheme: _floatingActionButtonThemeData,
    textTheme: _textTheme,
    textSelectionTheme: _textSelectionTheme,
  );

  static final ButtonStyle _elevatedButtonStyle = ElevatedButton.styleFrom(
    primary: _primaryColor,
    onPrimary: _accentColor,
    elevation: 20.0,
  );

  static const FloatingActionButtonThemeData _floatingActionButtonThemeData = FloatingActionButtonThemeData(
    foregroundColor: _primaryColor,
  );

  static const TextTheme _textTheme = TextTheme(
    bodyText1: TextStyle(
      fontSize: 20,
    ),
    bodyText2: TextStyle(
      fontSize: 18,
    ),
    headline1: TextStyle(
      fontSize: 70
    ),
    headline2: TextStyle(
      fontSize: 60,
    ),
    headline5: TextStyle(
      color: _accentColor,
      fontSize: 26,
    ),
  );

  static const TextSelectionThemeData _textSelectionTheme = TextSelectionThemeData(
    cursorColor: _primaryColor,
  );
}


