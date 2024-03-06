import 'package:flutter/material.dart';
import 'package:ytp_new/model/settings/settings.dart';
import 'package:ytp_new/provider/settings_provider.dart';

class SettingsThemeMode extends StatelessWidget {
  const SettingsThemeMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          if (Settings.themeMode != ThemeSetting.light) {
            SettingsProvider().themeMode = ThemeSetting.light;
          } else {
            SettingsProvider().themeMode = ThemeSetting.dark;
          }
        },
        child: const Text('theme'),
      ),
    );
  }
}
