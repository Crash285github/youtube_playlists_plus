import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/model/settings/settings.dart';
import 'package:ytp_new/provider/settings_provider.dart';

class SettingsThemeMode extends StatelessWidget {
  const SettingsThemeMode({super.key});

  bool get isLight => SettingsProvider().theme == ThemeSetting.light;

  void _toggle() {
    if (!isLight) {
      SettingsProvider().theme = ThemeSetting.light;
    } else {
      SettingsProvider().theme = ThemeSetting.dark;
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<SettingsProvider>(context);

    return InkWell(
      onTap: _toggle,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(Icons.dark_mode_outlined),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text("Dark mode"),
                ),
              ],
            ),
            Switch(
              value: !isLight,
              onChanged: (value) => _toggle(),
            )
          ],
        ),
      ),
    );
  }
}
