import 'package:flutter/material.dart';

/// The Application's configs, contains variables that should be accessed
/// everywhere in the application
class AppConfig {
  /// The navigator key for the left side of the screen on Split Screen Mode
  static final splitLeftNavigatorKey = GlobalKey<NavigatorState>();

  /// The navigator key for the right side of the screen on Split Screen Mode
  static final splitRightNavigatorKey = GlobalKey<NavigatorState>();

  /// The navigator key for the whole App
  static final mainNavigatorKey = GlobalKey<NavigatorState>();

  /// The duration of all the animations in the App
  static const defaultAnimationDuration = Duration(milliseconds: 300);

  //* The various keys for [Persistence] to find data
  static const preferencesConfirmDeletesKey = "confirmDeletes";
  static const preferencesBackgroundKey = "runInBackground";
  static const preferencesHideTopicKey = "hideTopic";
  static const preferencesSchemeKey = "appScheme";
  static const preferencesThemeKey = "appTheme";
  static const preferencesSplitKey = "split";
  static const playlistsKey = "playlists";
  static const anchorsKey = "anchors";
}
