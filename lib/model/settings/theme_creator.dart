import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:ytp_new/model/settings/settings.dart';

/// Generates the theme for the application
class ThemeCreator {
  static late ColorScheme _scheme;

  static bool get _isLight => Settings.theme == ThemeSetting.light;
  static bool get _isAmoled => Settings.theme == ThemeSetting.black;

  static Brightness get _brightness =>
      _isLight ? Brightness.light : Brightness.dark;

  /// The generated theme
  ///
  /// Will throw an error if [create()] has never been called before.
  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        colorScheme: _scheme,
        cardColor: _isAmoled ? Colors.black : _scheme.surface,
        drawerTheme: DrawerThemeData(
          backgroundColor: _isAmoled ? Colors.black : _scheme.surface,
        ),
        scaffoldBackgroundColor: _isLight
            ? _scheme.surfaceVariant
            : _isAmoled
                ? Colors.black
                : null,
        cardTheme: CardTheme(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          clipBehavior: Clip.antiAlias,
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
          color: _isAmoled ? Colors.black : _scheme.surface,
          elevation: _isAmoled ? 3 : 1,
        ),
        tooltipTheme: const TooltipThemeData(
          waitDuration: Duration(seconds: 1),
        ),
        appBarTheme: _isLight
            ? AppBarTheme(backgroundColor: _scheme.surfaceVariant)
            : _isAmoled
                ? const AppBarTheme(backgroundColor: Colors.black)
                : null,
      );

  /// Creates the colorScheme for the theme
  static Future createColorScheme() async {
    ColorScheme? colorScheme;

    //? Dynamic
    if (Settings.colorScheme == ColorSchemeSetting.dynamic) {
      try {
        colorScheme = ColorScheme.fromSeed(
          seedColor: (await DynamicColorPlugin.getAccentColor())!,
          brightness: _brightness,
        ).harmonized();
      } catch (_) {
        try {
          colorScheme = (await DynamicColorPlugin.getCorePalette())
              ?.toColorScheme(brightness: _brightness)
              .harmonized();
        } catch (_) {}
      }
    }
    //? Mono
    else if (Settings.colorScheme == ColorSchemeSetting.mono) {
      if (_isLight) {
        colorScheme = const ColorScheme.light().copyWith(
          primary: Colors.black,
          secondary: Colors.black,
          surfaceTint: Colors.black,
          primaryContainer: Colors.grey,
        );
      } else {
        colorScheme = const ColorScheme.dark().copyWith(
          primary: Colors.white,
          secondary: Colors.white,
          surfaceTint: Colors.white,
          primaryContainer: Colors.grey,
        );
      }
    }
    //? Other
    else {
      colorScheme = ColorScheme.fromSeed(
          seedColor: Settings.colorScheme.color!, brightness: _brightness);
    }

    _scheme = colorScheme!;
  }
}
