import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart'
    show StreamInfoIterableExt, YoutubeExplode;
import 'package:ytp_new/extensions/string_file_name.dart';
import 'package:ytp_new/model/video/video.dart';

class DownloadService {
  static final _yt = YoutubeExplode();

  /// Downloads a Youtube video
  static Future<bool> video(final Video video) async {
    final String? dir = await FilePicker.platform.getDirectoryPath();
    if (dir == null) return false;

    try {
      final streamManifest =
          await _yt.videos.streamsClient.getManifest(video.id);

      final muxedStreaminfo = streamManifest.muxed.withHighestBitrate();

      final muxedStream = _yt.videos.streamsClient.get(muxedStreaminfo);

      final file = File("$dir/${video.title.toFileName()}.mp4").openWrite();

      await muxedStream.pipe(file);
      await file.flush();
      await file.close();
    } catch (_) {
      return false;
    }

    return true;
  }
}
