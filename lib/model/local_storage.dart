import 'package:shared_preferences/shared_preferences.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/model/playlist_storage.dart';
import 'package:ytp_new/model/settings/settings.dart';

class LocalStorage {
  static late final SharedPreferences _prefs;
  static Future init() async => _prefs = await SharedPreferences.getInstance();

  static Future saveSettings() async => _prefs
    ..setInt("appTheme", Settings.themeMode.index)
    ..setInt("split", Settings.splitMode.index);

  static void loadSettings() async {
    final themeIndex = _prefs.getInt("appTheme");
    if (themeIndex != null) {
      Settings.themeMode = ThemeSetting.values[themeIndex];
    }

    final splitIndex = _prefs.getInt("split");
    if (splitIndex != null) {
      Settings.splitMode = SplitSetting.values[splitIndex];
    }
  }

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

  static Future loadPlaylists() async {
    final playlists = _prefs.getStringList("playlists");
    if (playlists == null) return;

    PlaylistStorage.replace(
      [...playlists.map((final json) => Playlist.fromJson(json))],
    );
  }
}
