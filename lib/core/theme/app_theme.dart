import 'package:flutter/material.dart';

class AppTheme {
  static final Color backgroundColor = Color(0xFF2B273D);
  static final Color primaryColor = Color(0xFFEFB92B);
  static final Color textColor = Color(0xFFEAEAEA);

  static ThemeData get darkTheme {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
      primary: primaryColor,
      onPrimary: backgroundColor,
      secondary: primaryColor.withAlpha(204),
      onSecondary: textColor,
      surface: backgroundColor,
      onSurface: textColor,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: colorScheme.secondary,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.secondary,
        iconSize: 30.0,
      ),
    );
  }
}
