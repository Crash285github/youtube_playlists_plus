import 'package:flutter/material.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/view/widget/app_navigator.dart';
import 'package:ytp_new/view/pages/about/about_page.dart';
import 'package:ytp_new/view/pages/home_page/drawer/app_data_buttons.dart';
import 'package:ytp_new/view/pages/home_page/drawer/settings/hide_topic_toggle.dart';
import 'package:ytp_new/view/pages/home_page/drawer/settings/reorder_toggle.dart';
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
                children: [
                  const SettingsThemeMode(),
                  const SettingsSchemeMode(),
                  const SettingsHideTopicToggle(),
                  const SettingsSplitMode(),
                  if (PlaylistStorageProvider().playlists.isNotEmpty)
                    const SettingsReorderToggle(),
                ],
              ),
            ),
            const AppDataButtons(),
            const Divider(indent: 8.0, endIndent: 8.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
              child: InkWell(
                onTap: () => AppNavigator.tryPushLeft(const AboutPage()),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.zero,
                  topLeft: Radius.zero,
                  bottomRight: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                overlayColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.primary.withOpacity(.3)),
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("About"),
                      Icon(Icons.info_outline),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
