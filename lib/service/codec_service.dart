import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ytp_new/config.dart';
import 'package:ytp_new/persistence/persistence.dart';
import 'package:ytp_new/model/playlist/playlist.dart';

/// Handles exporting & importing
class CodecService {
  /// Exports the app data
  static Future<bool> export() async {
    final String? dir = await FilePicker.platform.getDirectoryPath();
    if (dir == null) return false;

    final file =
        File("$dir/ytp_export${DateTime.now().microsecondsSinceEpoch}.json");

    final json = {
      AppConfig.preferencesThemeKey: Preferences.theme.index,
      AppConfig.preferencesSchemeKey: Preferences.colorScheme.index,
      AppConfig.preferencesConfirmDeletesKey: Preferences.confirmDeletes,
      AppConfig.preferencesHideTopicKey: Preferences.hideTopic,
      AppConfig.preferencesSplitKey: Preferences.splitMode.index,
      AppConfig.playlistsKey: PlaylistStorage.playlists,
      AppConfig.anchorsKey: AnchorStorage.anchors,
    };

    file.writeAsString(jsonEncode(json));
    return true;
  }

  /// Imports the app data
  static Future<Map?> import() async {
    final dir = await getApplicationDocumentsDirectory();
    final picked = await FilePicker.platform.pickFiles(
      initialDirectory: dir.path,
      allowMultiple: false,
      allowedExtensions: ['json'],
      type: FileType.custom,
    );
    if (picked == null) return null;

    try {
      final file = File(picked.files.first.path!);
      final json = jsonDecode(file.readAsStringSync());

      final Map<String, dynamic> parsed = {
        AppConfig.preferencesThemeKey:
            ThemePreference.values[json[AppConfig.preferencesThemeKey]],
        AppConfig.preferencesSchemeKey:
            ColorSchemePreference.values[json[AppConfig.preferencesSchemeKey]],
        AppConfig.preferencesConfirmDeletesKey:
            json[AppConfig.preferencesConfirmDeletesKey],
        AppConfig.preferencesSplitKey:
            SplitPreference.values[json[AppConfig.preferencesSplitKey]],
        AppConfig.preferencesHideTopicKey:
            json[AppConfig.preferencesHideTopicKey],
        AppConfig.playlistsKey: [
          ...(json['playlists'] as List).map(
            (final jsonPlylst) => Playlist.fromJson(jsonPlylst),
          )
        ],
        AppConfig.anchorsKey: [
          ...(json['anchors'] as List).map(
            (final jsonAnchor) => Anchor.fromJson(jsonAnchor),
          )
        ]
      };

      return parsed;
    } on Exception {
      return null;
    }
  }
}
