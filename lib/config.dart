import 'package:flutter/material.dart';

/// The Application's configs
class AppConfig {
  static final splitLeftNavigatorKey = GlobalKey<NavigatorState>();
  static final splitRightNavigatorKey = GlobalKey<NavigatorState>();
  static final mainNavigatorKey = GlobalKey<NavigatorState>();

  static const defaultAnimationDuration = Duration(milliseconds: 300);

  static const settingsThemeKey = "appTheme";
  static const settingsSchemeKey = "appScheme";
  static const settingsSplitKey = "split";
  static const settingsHideTopicKey = "hideTopic";
  static const playlistsKey = "playlists";
  static const anchorsKey = 'anchors';
}
