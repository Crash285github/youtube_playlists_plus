import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/model/settings/settings.dart';
import 'package:ytp_new/provider/settings_provider.dart';
import 'package:ytp_new/view/pages/home_page/drawer/settings/template.dart';

class SettingsThemeMode extends StatelessWidget {
  const SettingsThemeMode({super.key});

  bool get isLight => Settings.theme == ThemeSetting.light;
  bool get isAmoled => Settings.theme == ThemeSetting.amoled;

  void _toggleLightDark() {
    if (!isLight) {
      SettingsProvider().theme = ThemeSetting.light;
    } else {
      SettingsProvider().theme = ThemeSetting.dark;
    }
  }

  void _toggleAmoled() {
    if (!isAmoled) {
      SettingsProvider().theme = ThemeSetting.amoled;
    } else {
      SettingsProvider().theme = ThemeSetting.dark;
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<SettingsProvider>(context);

    return SettingTemplate(
      onTap: _toggleLightDark,
      onLongPress: _toggleAmoled,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.dark_mode_outlined),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(isAmoled ? "Black mode" : "Dark mode"),
              ),
            ],
          ),
          Switch(
            value: !isLight,
            onChanged: (_) => _toggleLightDark(),
          )
        ],
      ),
    );
  }
}
