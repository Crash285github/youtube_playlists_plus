import 'package:shared_preferences/shared_preferences.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/model/playlist_storage.dart';
import 'package:ytp_new/model/settings/settings.dart';

/// Handles saving and loading local data
class Persistence {
  static late final SharedPreferences _prefs;

  /// Gets the instance of `SharedPreferences`
  static Future init() async => _prefs = await SharedPreferences.getInstance();

  /// Saves `Settings` to `Persistence`
  static Future saveSettings() async => _prefs
    ..setInt("appTheme", Settings.theme.index)
    ..setInt('appScheme', Settings.colorScheme.index)
    ..setInt("split", Settings.splitMode.index)
    ..setBool('hideTopic', Settings.hideTopic);

  /// Load & apply persisted settings
  ///
  /// Does not notify
  static void loadSettings() async {
    final themeIndex = _prefs.getInt("appTheme");
    if (themeIndex != null) {
      Settings.theme = ThemeSetting.values[themeIndex];
    }

    final colorIndex = _prefs.getInt('appScheme');
    if (colorIndex != null) {
      Settings.colorScheme = ColorSchemeSetting.values[colorIndex];
    }

    final splitIndex = _prefs.getInt("split");
    if (splitIndex != null) {
      Settings.splitMode = SplitSetting.values[splitIndex];
    }

    final hideTopic = _prefs.getBool('hideTopic');
    if (hideTopic != null) {
      Settings.hideTopic = hideTopic;
    }
  }

  /// Saves all `Playlists` to `Persistence`
  static Future savePlaylists() async {
    _prefs.setStringList(
      "playlists",
      [
        ...PlaylistStorage.playlists.map((final playlist) {
          playlist.applyPendingHistory();
          return playlist.toJson();
        })
      ],
    );
  }

  /// Loads playlists from persistence
  ///
  /// Does not notify
  static Future loadPlaylists() async {
    final playlists = _prefs.getStringList("playlists");
    if (playlists == null) return;

    PlaylistStorage.replace(
      [...playlists.map((final json) => Playlist.fromJson(json))],
    );
  }
}
