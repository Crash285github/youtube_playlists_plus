import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:ytp_new/model/settings/settings.dart';

class ThemeCreator {
  static bool get _isLight => Settings.theme == ThemeSetting.light;
  static Brightness get _brightness =>
      _isLight ? Brightness.light : Brightness.dark;

  static late ThemeData theme;

  static Future create() async {
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

    theme = ThemeData(
      colorScheme: colorScheme,
    );
  }
}
