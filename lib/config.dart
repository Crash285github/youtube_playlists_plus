import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

/// The Application's configs
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
  static const settingsConfirmDeletesKey = "confirmDeletes";
  static const settingsBackgroundKey = "runInBackground";
  static const settingsHideTopicKey = "hideTopic";
  static const settingsSchemeKey = "appScheme";
  static const settingsThemeKey = "appTheme";
  static const settingsSplitKey = "split";
  static const playlistsKey = "playlists";
  static const anchorsKey = "anchors";

  /// The [YoutubeExplode] client used through the entire App
  static final youtube = YoutubeExplode();
}
