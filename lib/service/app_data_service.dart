import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ytp_new/model/playlist_storage.dart';
import 'package:ytp_new/model/settings/settings.dart';

class AppDataService {
  static Future<bool> export() async {
    final String? dir = await FilePicker.platform.getDirectoryPath();
    if (dir == null) return false;

    final file =
        File("$dir/ytp_export${DateTime.now().microsecondsSinceEpoch}.json");

    final json = {
      'appTheme': Settings.theme.index,
      'appScheme': Settings.colorScheme.index,
      'split': Settings.splitMode.index,
      'playlists': PlaylistStorage.playlists,
    };

    file.writeAsString(jsonEncode(json));
    return true;
  }

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

    return jsonDecode(file.readAsStringSync());
  }
}
