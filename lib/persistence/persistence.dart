library persistence;

import 'dart:convert';
import 'dart:io';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ytp_new/config.dart';

import 'package:ytp_new/model/playlist/playlist.dart';

part 'anchor_storage.dart';
part 'playlist_storage.dart';
part 'preferences.dart';
part 'theme_creator.dart';
part 'codec.dart';

/// Handles saving and loading local data
class Persistence {
  static String? currentlyShowingPlaylistId;

  static late final SharedPreferences _prefs;

  /// Gets the instance of `SharedPreferences`
  static Future init() async => _prefs = await SharedPreferences.getInstance();

  /// Saves [Preferences] to [Persistence]
  static Future savePreferences() async => _prefs
    ..setInt(
      AppConfig.preferencesThemeKey,
      Preferences.theme.index,
    )
    ..setInt(
      AppConfig.preferencesSchemeKey,
      Preferences.colorScheme.index,
    )
    ..setInt(
      AppConfig.preferencesSplitKey,
      Preferences.splitMode.index,
    )
    ..setBool(
      AppConfig.preferencesHideTopicKey,
      Preferences.hideTopic,
    )
    ..setBool(
      AppConfig.preferencesConfirmDeletesKey,
      Preferences.confirmDeletes,
    )
    ..setBool(
      AppConfig.preferencesBackgroundKey,
      Preferences.runInBackground,
    );

  /// Loads [Preferences] from [Persistence]
  ///
  /// Does not notify
  static void loadPreferences() {
    final themeIndex = _prefs.getInt(AppConfig.preferencesThemeKey);
    if (themeIndex != null) {
      Preferences.theme = ThemePreference.values[themeIndex];
    }

    final colorIndex = _prefs.getInt(AppConfig.preferencesSchemeKey);
    if (colorIndex != null) {
      Preferences.colorScheme = ColorSchemePreference.values[colorIndex];
    }

    final splitIndex = _prefs.getInt(AppConfig.preferencesSplitKey);
    if (splitIndex != null) {
      Preferences.splitMode = SplitPreference.values[splitIndex];
    }

    final hideTopic = _prefs.getBool(AppConfig.preferencesHideTopicKey);
    if (hideTopic != null) {
      Preferences.hideTopic = hideTopic;
    }

    final confirmDeletes =
        _prefs.getBool(AppConfig.preferencesConfirmDeletesKey);
    if (confirmDeletes != null) {
      Preferences.confirmDeletes = confirmDeletes;
    }

    final runInBackround = _prefs.getBool(AppConfig.preferencesBackgroundKey);
    if (runInBackround != null) {
      Preferences.runInBackground = runInBackround;
    }
  }

  /// Saves all [Playlist]s to [Persistence]
  static Future savePlaylists() async => _prefs.setStringList(
        AppConfig.playlistsKey,
        [
          ...PlaylistStorage.playlists.map(
            (final playlist) => playlist.toJson(),
          ),
        ],
      );

  /// Loads [Playlist]s from [Persistence]
  ///
  /// Does not notify
  static void loadPlaylists() {
    final playlists = _prefs.getStringList(AppConfig.playlistsKey);
    if (playlists == null) return;

    PlaylistStorage.replace(
      [...playlists.map((final json) => Playlist.fromJson(json))],
    );
  }

  /// Saves all [Anchor]s to [Persistence]
  static Future saveAnchors() async {
    _prefs.setStringList(
      AppConfig.anchorsKey,
      [
        ...AnchorStorage.anchors.map(
          (final anchor) => anchor.toJson(),
        ),
      ],
    );
  }

  /// Loads [Anchor]s from [Persistence]
  ///
  /// Does not notify
  static void loadAnchors() {
    final anchors = _prefs.getStringList(AppConfig.anchorsKey);
    if (anchors == null) return;

    AnchorStorage.replace(
      [...anchors.map((final json) => Anchor.fromJson(json))],
    );
  }
}
