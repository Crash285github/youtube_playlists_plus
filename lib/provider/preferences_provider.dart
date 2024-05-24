import 'package:flutter/material.dart';

import 'package:ytp_new/config.dart';
import 'package:ytp_new/persistence/persistence.dart';
import 'package:ytp_new/provider/anchor_storage_provider.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/service/navigator_service.dart';

class PreferencesProvider extends ChangeNotifier {
  /// The current [ThemePreference] of the app
  ThemePreference get theme => Preferences.theme;
  set theme(final ThemePreference theme) {
    if (Preferences.theme == theme) return;

    Preferences.theme = theme;
    ThemeCreator.createColorScheme().whenComplete(() => notifyListeners());

    Persistence.savePreferences();
  }

  /// The current [ColorSchemePreference] of the app
  ColorSchemePreference get colorScheme => Preferences.colorScheme;
  set colorScheme(final ColorSchemePreference colorScheme) {
    if (Preferences.colorScheme == colorScheme) return;

    Preferences.colorScheme = colorScheme;
    ThemeCreator.createColorScheme().then((value) => notifyListeners());

    Persistence.savePreferences();
  }

  /// The current [SplitPreference] of the app
  SplitPreference get splitMode => Preferences.splitMode;
  set splitMode(final SplitPreference splitMode) {
    if (Preferences.splitMode == splitMode) return;

    Preferences.splitMode = splitMode;
    notifyListeners();

    Persistence.savePreferences();
  }

  /// Whether to hide the `- Topic` suffix from authors
  bool get hideTopic => Preferences.hideTopic;
  set hideTopic(final bool hideTopic) {
    if (Preferences.hideTopic == hideTopic) return;

    Preferences.hideTopic = hideTopic;
    notifyListeners();

    Persistence.savePreferences();
  }

  /// Whether to allow reordering of [Playlist]s
  bool get canReorder => Preferences.canReorder;
  set canReorder(final bool canReorder) {
    if (canReorder == Preferences.canReorder) return;

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
    if (Preferences.confirmDeletes == confirmDeletes) return;

    Preferences.confirmDeletes = confirmDeletes;
    notifyListeners();

    Persistence.savePreferences();
  }

  /// Whether the app can run in the background (mobile only)
  bool get runInBackground => Preferences.runInBackground;
  set runInBackground(final bool runInBackground) {
    if (Preferences.runInBackground == runInBackground) return;

    Preferences.runInBackground = runInBackground;
    notifyListeners();

    Persistence.savePreferences();
  }

  /// Exports the app data
  Future<void> export() async => Codec.export();

  bool _managingAppData = false;

  /// Whether the app is currently managing data
  ///
  /// The codec buttons disable while this is true
  bool get managingAppData => _managingAppData;
  set managingAppData(final bool managingAppData) {
    if (_managingAppData == managingAppData) return;

    _managingAppData = managingAppData;
    notifyListeners();
  }

  /// Imports the app data
  Future<void> import() async {
    managingAppData = true;
    final imported = await Codec.import().onError((_, __) => null);
    if (imported == null) {
      managingAppData = false;
      return;
    }

    NavigatorService.tryPopRight();

    try {
      theme = imported[AppConfig.preferencesThemeKey];
    } catch (_) {}

    try {
      colorScheme = imported[AppConfig.preferencesSchemeKey];
    } catch (_) {}

    try {
      splitMode = imported[AppConfig.preferencesSplitKey];
    } catch (_) {}

    try {
      hideTopic = imported[AppConfig.preferencesHideTopicKey];
    } catch (_) {}

    try {
      PlaylistStorageProvider().replace(imported[AppConfig.playlistsKey]);
      Persistence.savePlaylists();
    } catch (_) {}

    try {
      AnchorStorageProvider().replace(imported[AppConfig.anchorsKey]);
      Persistence.saveAnchors();
    } catch (_) {}

    managingAppData = false;
  }

  //_ Singleton
  static final _provider = PreferencesProvider._();
  factory PreferencesProvider() => _provider;
  PreferencesProvider._();
}
