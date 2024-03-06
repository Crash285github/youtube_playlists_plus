import 'package:flutter/material.dart';
import 'package:ytp_new/model/settings/app_theme_mode.dart';
import 'package:ytp_new/model/settings/settings.dart';
import 'package:ytp_new/provider/settings_provider.dart';

class ThemeSetting extends StatelessWidget {
  const ThemeSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          if (Settings.themeMode != AppThemeMode.light) {
            SettingsProvider().themeMode = AppThemeMode.light;
          } else {
            SettingsProvider().themeMode = AppThemeMode.dark;
          }
        },
        child: const Text('theme'),
      ),
    );
  }
}
