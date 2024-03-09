import 'package:flutter/material.dart';
import 'package:ytp_new/view/pages/home_page/drawer/settings/scheme_mode.dart';
import 'package:ytp_new/view/pages/home_page/drawer/settings/split_mode.dart';
import 'package:ytp_new/view/pages/home_page/drawer/settings/theme_mode.dart';

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Settings",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            const Divider(indent: 8.0, endIndent: 8.0),
            Expanded(
              child: ListView(
                children: const [
                  SettingsThemeMode(),
                  SettingsSchemeMode(),
                  SettingsSplitMode(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
