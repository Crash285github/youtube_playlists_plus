import 'dart:async';
import 'dart:io';

import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/model/video.dart';

class YoutubeService {
  static final youtube = yt.YoutubeExplode();

  static Future<Playlist> download(Playlist playlist) async {
    final metadata = await youtube.playlists
        .get(playlist.id)
        .timeout(const Duration(seconds: 20))
        .onError((error, stackTrace) {
      if (error is HandshakeException) {
        throw YoutubeServiceException.handshake(
            "Couldn't download [${playlist.title}]: HandshakeException.");
      }
      if (error is TimeoutException) {
        throw YoutubeServiceException.timeout(
            "Downloading [${playlist.title}] timed out.");
      }

      throw YoutubeServiceException.unknown(
          "Unknown error occurred while downloading [${playlist.title}].");
    });

    List<Video> videos = [];
    await for (var video in youtube.playlists.getVideos(playlist.id)) {
      videos.add(
        Video(
          id: video.id.toString(),
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
