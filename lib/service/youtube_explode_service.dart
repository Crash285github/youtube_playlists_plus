import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:ytp_new/config.dart';
import 'package:ytp_new/model/playlist/playlist.dart';

/// Handles the communication with Youtube
class YoutubeService {
  /// Fetches a [Playlist]'s data
  static Future<Playlist> fetch(final Playlist playlist) async =>
      await Isolate.run(() => _fetch(playlist));

  static Future<Playlist> _fetch(final Playlist playlist) async {
    final metadata = await AppConfig.youtube.playlists
        .get(playlist.id)
        .timeout(const Duration(seconds: 20))
        .onError((error, stackTrace) {
      if (error is HandshakeException) {
        throw YoutubeServiceException.handshake(
          "Couldn't download [${playlist.title}]: HandshakeException.",
        );
      }
      if (error is TimeoutException) {
        throw YoutubeServiceException.timeout(
          "Downloading [${playlist.title}] timed out.",
        );
      }

      throw YoutubeServiceException.unknown(
        "Unknown error occurred while downloading [${playlist.title}].",
      );
    });

    final List<Video> videos = [];
    await for (final video
        in AppConfig.youtube.playlists.getVideos(playlist.id)) {
      videos.add(
        Video(
          id: video.id.toString(),
          playlistId: playlist.id,
          title: video.title,
          author: video.author,
          thumbnail: video.thumbnails.mediumResUrl,
        ),
      );
    }

    return Playlist(
      id: playlist.id,
      title: metadata.title,
      author: metadata.author,
      description: metadata.description,
      thumbnail: playlist.thumbnail,
      videos: videos,
    );
  }
}

class YoutubeServiceException implements Exception {
  final YoutubeServiceExceptionReason reason;
  final String message;
  YoutubeServiceException._(this.reason, this.message);

  factory YoutubeServiceException.timeout(final String message) =>
      YoutubeServiceException._(YoutubeServiceExceptionReason.timeout, message);

  factory YoutubeServiceException.handshake(final String message) =>
      YoutubeServiceException._(
          YoutubeServiceExceptionReason.handshake, message);

  factory YoutubeServiceException.unknown(final String message) =>
      YoutubeServiceException._(YoutubeServiceExceptionReason.unknown, message);

  @override
  String toString() => "YoutubeExplodeServiceException: $message";
}

enum YoutubeServiceExceptionReason { timeout, handshake, unknown }
