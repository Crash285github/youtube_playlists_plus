import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ytp_new/config.dart';
import 'package:ytp_new/model/anchor_storage.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/model/playlist_storage.dart';
import 'package:ytp_new/model/settings/settings.dart';
import 'package:ytp_new/model/video/anchor.dart';

/// Handles exporting & importing
class CodecService {
  /// Exports the app data
  static Future<bool> export() async {
    final String? dir = await FilePicker.platform.getDirectoryPath();
    if (dir == null) return false;

    final file =
        File("$dir/ytp_export${DateTime.now().microsecondsSinceEpoch}.json");

    final json = {
      AppConfig.settingsThemeKey: Settings.theme.index,
      AppConfig.settingsSchemeKey: Settings.colorScheme.index,
      AppConfig.settingsSplitKey: Settings.splitMode.index,
      AppConfig.settingsHideTopicKey: Settings.hideTopic,
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

    final file = File(picked.files.first.path!);
    final json = jsonDecode(file.readAsStringSync());

    final Map<String, dynamic> parsed = {
      AppConfig.settingsThemeKey:
          ThemeSetting.values[json[AppConfig.settingsThemeKey]],
      AppConfig.settingsSchemeKey:
          ColorSchemeSetting.values[json[AppConfig.settingsSchemeKey]],
      AppConfig.settingsSplitKey:
          SplitSetting.values[json[AppConfig.settingsSplitKey]],
      AppConfig.settingsHideTopicKey: json[AppConfig.settingsHideTopicKey],
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
  }
}
