import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// [AppTheme] is a class that contains the theme data for the application.
/// The theme data is used to style the widgets in the application.
///
/// The class contains two static methods that return the light and dark themes
/// for the application. The themes are created using the [build] method, which
/// takes an optional `brightness` parameter that specifies the brightness of
/// the theme.
final class AppTheme {
  static ThemeData get light => build();

  static ThemeData get dark => build(brightness: Brightness.dark);

  static ThemeData build({
    Brightness brightness = Brightness.light,
  }) {
    final systemUiOverlayStyle = brightness == Brightness.light
        ? SystemUiOverlayStyle.dark
        : SystemUiOverlayStyle.light;

    return ThemeData(
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        brightness: brightness,
        seedColor: Colors.deepPurple,
      ),
      appBarTheme: AppBarTheme(systemOverlayStyle: systemUiOverlayStyle),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.all(12),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedIconTheme: IconThemeData(size: 24),
        unselectedIconTheme: IconThemeData(size: 24),
        selectedLabelStyle: TextStyle(fontSize: 12),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
