import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

final light = ThemeData(
  primarySwatch: const MaterialColor(4278797515, {
    50: Color(0xffe7eefe),
    100: Color(0xffcedcfd),
    200: Color(0xff9dbafb),
    300: Color(0xff6c97f9),
    400: Color(0xff3c74f6),
    500: Color(0xff0b52f4),
    600: Color(0xff0941c3),
    700: Color(0xff063193),
    800: Color(0xff042162),
    900: Color(0xff021031)
  }),
  brightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primaryColor: const Color(0xff0a4396),
  primaryColorLight: const Color(0xffcedcfd),
  primaryColorDark: const Color(0xff0a4396),
  cardColor: const Color(0xffffffff),
  errorColor: const Color(0xffef4444),
  scaffoldBackgroundColor: const Color(0xffffffff),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff0a4396),
    secondary: Color(0xff0a4396),
    surface: Color(0xFFF5F5F5),
    background: Color(0xffe2e8f0),
    error: Color(0xffef4444),
    onPrimary: Color(0xffF1F5F9),
    onSecondary: Color(0xffF1F5F9),
    secondaryContainer: Color(0xff94a3b8),
    onSurface: Color(0xff0f172a),
    onBackground: Color(0xffF1F5F9),
    onError: Color(0xfff1f5f9),
  ),
);

final dark = ThemeData(
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: const Color(0xff9dbafb),
    primaryColorLight: const Color(0xffcedcfd),
    primaryColorDark: const Color(0xff6c97f9),
    scaffoldBackgroundColor: const Color(0xff121212),
    errorColor: const Color(0xfffca5a5),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff9dbafb),
      secondary: Color(0xff6c97f9),
      secondaryContainer: Color(0xff323232),
      surface: Color(0xff1f1f1f),
      background: Color(0xff121212),
      error: Color(0xfffca5a5),
      onPrimary: Color(0xff1f1f1f),
      onSecondary: Color(0xff1f1f1f),
      onSurface: Color(0xffffffff),
      onBackground: Color(0xffffffff),
      onError: Color(0xfff1f5f9),
    ));

final lightTheme =
    AppTheme(id: "light", description: "Light Theme", data: light);
final darkTheme = AppTheme(id: "dark", description: "Dark Theme", data: dark);
