part of '../preferences_drawer.dart';

class _ToggleTheme extends StatelessWidget {
  const _ToggleTheme();

  bool get isLight => Settings.theme == ThemeSetting.light;
  bool get isBlack => Settings.theme == ThemeSetting.black;

  void _toggleLight() {
    if (!isLight) {
      SettingsProvider().theme = ThemeSetting.light;
    } else {
      SettingsProvider().theme = ThemeSetting.dark;
    }
  }

  void _toggleBlack() {
    if (!isBlack) {
      SettingsProvider().theme = ThemeSetting.black;
    } else {
      SettingsProvider().theme = ThemeSetting.dark;
    }
  }

  @override
  Widget build(BuildContext context) {
    context.select<SettingsProvider, ThemeSetting>(
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
