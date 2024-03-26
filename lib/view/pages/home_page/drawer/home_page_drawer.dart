import 'dart:io';

import 'package:flutter/material.dart';

import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/view/pages/about/about_page.dart';
import 'package:ytp_new/view/pages/home_page/drawer/codec_buttons.dart';
import 'package:ytp_new/view/pages/home_page/drawer/settings/confirm_delete_toggle.dart';
import 'package:ytp_new/view/pages/home_page/drawer/settings/hide_topic_toggle.dart';
import 'package:ytp_new/view/pages/home_page/drawer/settings/reorder_toggle.dart';
import 'package:ytp_new/view/pages/home_page/drawer/settings/scheme_mode.dart';
import 'package:ytp_new/view/pages/home_page/drawer/settings/split_mode.dart';
import 'package:ytp_new/view/pages/home_page/drawer/settings/theme_mode.dart';
import 'package:ytp_new/view/widget/app_navigator.dart';
import 'package:ytp_new/view/widget/fading_listview.dart';

class HomePageDrawer extends StatelessWidget {
  HomePageDrawer({super.key});

  final preferences = <Widget>[
    const SettingsThemeMode(),
    const SettingsSchemeMode(),
    const SettingsConfirmDeleteToggle(),
    const SettingsHideTopicToggle(),
    const SettingsSplitMode(),
    if (PlaylistStorageProvider().playlists.isNotEmpty)
      const SettingsReorderToggle(),
  ];

  @override
  Widget build(BuildContext context) {
    final child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Text(
            "Preferences",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        const Divider(indent: 8.0, endIndent: 8.0),
        Expanded(
          child: FadingListView(
            itemCount: preferences.length,
            itemBuilder: (context, index) => preferences[index],
          ),
        ),
        const CodecButtons(),
        const Divider(indent: 8.0, endIndent: 8.0),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
          child: InkWell(
            onTap: () => AppNavigator.pushMain(const AboutPage()),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.zero,
              topLeft: Radius.zero,
              bottomRight: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            overlayColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.primary.withOpacity(.3)),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
    );

    if (Platform.isAndroid) {
      return SafeArea(child: Drawer(child: child));
    } else {
      return Padding(
        padding: const EdgeInsets.only(
          top: kToolbarHeight,
          bottom: 16.0,
          right: 16.0,
          left: 16.0,
        ),
        child: Drawer(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: child,
        ),
      );
    }
  }
}
