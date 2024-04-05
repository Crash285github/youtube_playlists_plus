part of preferences_drawer;

class _ToggleTheme extends StatelessWidget {
  const _ToggleTheme();

  bool get isLight => Preferences.theme == ThemePreference.light;
  bool get isBlack => Preferences.theme == ThemePreference.black;

  void _toggleLight() {
    if (!isLight) {
      PreferencesProvider().theme = ThemePreference.light;
    } else {
      PreferencesProvider().theme = ThemePreference.dark;
    }
  }

  void _toggleBlack() {
    if (!isBlack) {
      PreferencesProvider().theme = ThemePreference.black;
    } else {
      PreferencesProvider().theme = ThemePreference.dark;
    }
  }

  @override
  Widget build(BuildContext context) {
    context.select<PreferencesProvider, ThemePreference>(
      (final settings) => settings.theme,
    );

    return _SettingTemplate(
      onTap: _toggleLight,
      onLongPress: _toggleBlack,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.dark_mode_outlined),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(isBlack ? "Black mode" : "Dark mode"),
              ),
            ],
          ),
          Switch(
            value: !isLight,
            onChanged: (_) => _toggleLight(),
          )
        ],
      ),
    );
  }
}
