part of persistence;

/// Generates the theme for the application
class ThemeCreator {
  static late ColorScheme _scheme;

  static bool get _isLight => Preferences.theme == ThemePreference.light;
  static bool get _isAmoled => Preferences.theme == ThemePreference.black;

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
        tooltipTheme: TooltipThemeData(
          waitDuration: const Duration(seconds: 1),
          decoration: BoxDecoration(
            color: _scheme.secondary,
            borderRadius: BorderRadius.circular(8.0),
          ),
          textStyle: TextStyle(
            color: _scheme.onPrimary,
          ),
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
    if (Preferences.colorScheme == ColorSchemePreference.dynamic) {
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
    else if (Preferences.colorScheme == ColorSchemePreference.mono) {
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
          seedColor: Preferences.colorScheme.color!, brightness: _brightness);
    }

    _scheme = colorScheme!;
  }
}
