import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:youtube_explode_dart/youtube_explode_dart.dart'
    hide Playlist, Video;
import 'package:ytp_new/config.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/service/popup_service.dart';

/// Handles the communication with Youtube
class YoutubeService {
  /// The [YoutubeExplode] client used to fetch & download
  static final youtube = YoutubeExplode();

  /// Fetches a [Playlist]'s data
  static Future<Playlist> fetch(final String id) async =>
      await Isolate.run(() => _fetch(id));

  static Future<Playlist> _fetch(final String id) async {
    final metadata = await youtube.playlists
        .get(id)
        .timeout(const Duration(seconds: 20))
        .onError((error, _) {
      if (error is HandshakeException) {
        PopupService.showError(
          context: AppConfig.mainNavigatorKey.currentContext!,
          message: "Couldn't download [$id]: HandshakeException.",
        );
      }
      if (error is TimeoutException) {
        PopupService.showError(
          context: AppConfig.mainNavigatorKey.currentContext!,
          message: "Downloading [$id] timed out.",
        );
      }

      PopupService.showError(
        context: AppConfig.mainNavigatorKey.currentContext!,
        message: "Unknown error occurred while downloading [$id].",
      );

      throw Exception(error.toString());
    });

    final List<Video> videos = [];
    await for (final video in youtube.playlists.getVideos(id)) {
      videos.add(
        Video(
          id: video.id.toString(),
          playlistId: id,
          title: video.title,
          author: video.author,
          thumbnail: video.thumbnails.mediumResUrl,
        ),
      );
    }

    return Playlist(
      id: id,
      title: metadata.title,
      author: metadata.author,
      description: metadata.description,
      thumbnail: videos.firstOrNull?.thumbnail ?? "",
      videos: videos,
    );
  }
}
