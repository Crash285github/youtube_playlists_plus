part of persistence;

/// The application's theme brightness preference options
enum ThemePreference { light, dark, black }

/// The application's split mode preference options
enum SplitPreference { disabled, even, uneven }

/// The application's theme color preference options
enum ColorSchemePreference {
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
  const ColorSchemePreference(this.color);
}

/// The application's current preferences
class Preferences {
  /// The current brightness of the app's theme
  static ThemePreference theme = ThemePreference.light;

  /// The current color of the app's theme
  static ColorSchemePreference colorScheme = ColorSchemePreference.blue;

  /// The current split mode of the app
  static SplitPreference splitMode = SplitPreference.disabled;

  /// Whether the application is currently in Split mode
  ///
  /// This can vary based on the device size.
  static bool isSplit = false;

  /// Should we hide '- Topic' from channel names
  static bool hideTopic = false;

  /// Can the app's playlists be reordered currently
  static bool canReorder = false;

  /// Should the app ask before proceeding deletions
  static bool confirmDeletes = true;

  /// Can the app run in the background (mobile only)
  static bool runInBackground = false;
}
