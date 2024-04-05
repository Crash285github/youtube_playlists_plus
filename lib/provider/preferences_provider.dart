import 'package:flutter/material.dart';

import 'package:ytp_new/config.dart';
import 'package:ytp_new/model/persistence.dart';
import 'package:ytp_new/model/theme_creator.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/service/codec_service.dart';
import 'package:ytp_new/view/widget/app_navigator.dart';

class PreferencesProvider extends ChangeNotifier {
  /// The current [ThemeData] of the app
  ThemeData get themeData =>
      theme == ThemePreference.dark ? ThemeData.dark() : ThemeData.light();

  /// The current [ThemePreference] of the app
  ThemePreference get theme => Preferences.theme;
  set theme(final ThemePreference setting) {
    Preferences.theme = setting;
    ThemeCreator.createColorScheme().whenComplete(() => notifyListeners());

    Persistence.savePreferences();
  }

  /// The current [SplitPreference] of the app
  SplitPreference get splitMode => Preferences.splitMode;
  set splitMode(final SplitPreference setting) {
    Preferences.splitMode = setting;
    notifyListeners();

    Persistence.savePreferences();
  }

  /// The current [ColorSchemePreference] of the app
  ColorSchemePreference get colorScheme => Preferences.colorScheme;
  set colorScheme(final ColorSchemePreference colorScheme) {
    Preferences.colorScheme = colorScheme;
    ThemeCreator.createColorScheme().then((value) => notifyListeners());

    Persistence.savePreferences();
  }

  /// Whether to hide the `- Topic` suffix from authors
  bool get hideTopic => Preferences.hideTopic;
  set hideTopic(final bool hideTopic) {
    Preferences.hideTopic = hideTopic;
    notifyListeners();

    Persistence.savePreferences();
  }

  /// Whether to allow reordering of [Playlist]s
  bool get canReorder => Preferences.canReorder;
  set canReorder(final bool canReorder) {
    Preferences.canReorder = canReorder;
    notifyListeners();

    //? save changed order on finish
    if (!canReorder) {
      Persistence.savePlaylists();
    }
  }

  /// Whether the app should ask before proceeding with deletions
  bool get confirmDeletes => Preferences.confirmDeletes;
  set confirmDeletes(final bool confirmDeletes) {
    Preferences.confirmDeletes = confirmDeletes;
    notifyListeners();

    Persistence.savePreferences();
  }

  /// Whether the app can run in the background (mobile only)
  bool get runInBackground => Preferences.runInBackground;
  set runInBackground(final bool runInBackground) {
    Preferences.runInBackground = runInBackground;
    notifyListeners();

    Persistence.savePreferences();
  }

  /// Exports the app data
  Future export() async => CodecService.export();

  bool _managingAppData = false;

  /// Whether the app is currently managing data
  bool get managingAppData => _managingAppData;
  set managingAppData(final bool value) {
    _managingAppData = value;
    notifyListeners();
  }

  /// Imports the app data
  Future import() async {
    managingAppData = true;
    final imported = await CodecService.import().onError((_, __) => null);
    if (imported == null) {
      managingAppData = false;
      return;
    }

    AppNavigator.tryPopRight();

    try {
      theme = imported[AppConfig.preferencesThemeKey];
    } finally {}

    try {
      colorScheme = imported[AppConfig.preferencesSchemeKey];
    } finally {}

    try {
      splitMode = imported[AppConfig.preferencesSplitKey];
    } finally {}

    try {
      hideTopic = imported[AppConfig.preferencesHideTopicKey];
    } finally {}

    try {
      PlaylistStorageProvider().replace(imported[AppConfig.playlistsKey]);
      Persistence.savePlaylists();
    } finally {}

    managingAppData = false;
  }

  //_ Singleton
  static final _provider = PreferencesProvider._();
  factory PreferencesProvider() => _provider;
  PreferencesProvider._();
}
