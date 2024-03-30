library preferences_drawer;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'package:ytp_new/config.dart';
import 'package:ytp_new/extensions/extensions.dart';
import 'package:ytp_new/model/persistence.dart';
import 'package:ytp_new/provider/fetching_provider.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/provider/settings_provider.dart';
import 'package:ytp_new/service/background_service.dart';
import 'package:ytp_new/view/pages/about/about_page.dart';
import 'package:ytp_new/view/widget/app_navigator.dart';
import 'package:ytp_new/view/widget/fading_listview.dart';

part 'codec_buttons.dart';
part 'settings/toggle_background.dart';
part 'settings/toggle_confirm_delete.dart';
part 'settings/toggle_hide_topic.dart';
part 'settings/toggle_reorder.dart';
part 'settings/select_scheme.dart';
part 'settings/select_split.dart';
part 'settings/template.dart';
part 'settings/toggle_theme.dart';

class PreferencesDrawer extends StatelessWidget {
  PreferencesDrawer({super.key});

  final preferences = <Widget>[
    const _ToggleTheme(),
    const _SelecteScheme(),
    const _ToggleConfirmDelete(),
    const _ToggleHideTopic(),
    const _SelectSplit(),
    if (Platform.isAndroid) const _ToggleBackground(),
    if (PlaylistStorageProvider().playlists.isNotEmpty) const _ToggleReorder(),
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
