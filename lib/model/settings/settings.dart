import 'package:flutter/material.dart';

/// The application's theme brightness settings
enum ThemeSetting { light, dark, black }

/// The application's split mode settings
enum SplitSetting { disabled, even, uneven }

/// The application's theme color settings
enum ColorSchemeSetting {
  dynamic(null),
  mono(Colors.grey),
  red(Colors.red),
  pink(Colors.pink),
  orange(Colors.orange),
  yellow(Colors.yellow),
  green(Colors.green),
  cyan(Colors.cyan),
  blue(Colors.blue),
  indigo(Colors.indigo),
  purple(Colors.purple),
  ;

  final Color? color;
  const ColorSchemeSetting(this.color);
}

/// The application's current settings
class Settings {
  /// The current brightness of the app's theme
  static ThemeSetting theme = ThemeSetting.light;

  /// The current color of the app's theme
  static ColorSchemeSetting colorScheme = ColorSchemeSetting.blue;

  /// The current split mode of the app
  static SplitSetting splitMode = SplitSetting.disabled;
  static bool isSplit = false;

  /// Should we hide '- Topic' from channel names
  static bool hideTopic = false;

  /// Can the app's playlists be reordered currently
  static bool canReorder = false;

  /// Should the app ask before proceeding deletions
  static bool confirmDeletes = true;
}
