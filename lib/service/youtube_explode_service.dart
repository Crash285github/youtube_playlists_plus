import 'dart:async';
import 'dart:io';

import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/model/video.dart';

class YoutubeExplodeService {
  static final youtube = yt.YoutubeExplode();

  static Future<Playlist> download(Playlist playlist) async {
    final metadata = await youtube.playlists
        .get(playlist.id)
        .timeout(const Duration(seconds: 20))
        .onError((error, stackTrace) {
      if (error is HandshakeException) {
        throw YoutubeExplodeServiceException.handshake(
            "Couldn't download [${playlist.title}]: HandshakeException.");
      }
      if (error is TimeoutException) {
        throw YoutubeExplodeServiceException.timeout(
            "Downloading [${playlist.title}] timed out.");
      }

      throw YoutubeExplodeServiceException.unknown(
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

class YoutubeExplodeServiceException implements Exception {
  final YoutubeExplodeServiceExceptionReason reason;
  final String message;
  YoutubeExplodeServiceException._(this.reason, this.message);

  factory YoutubeExplodeServiceException.timeout(final String message) =>
      YoutubeExplodeServiceException._(
          YoutubeExplodeServiceExceptionReason.timeout, message);

  factory YoutubeExplodeServiceException.handshake(final String message) =>
      YoutubeExplodeServiceException._(
          YoutubeExplodeServiceExceptionReason.handshake, message);

  factory YoutubeExplodeServiceException.unknown(final String message) =>
      YoutubeExplodeServiceException._(
          YoutubeExplodeServiceExceptionReason.unknown, message);

  @override
  String toString() => "YoutubeExplodeServiceException: $message";
}

enum YoutubeExplodeServiceExceptionReason { timeout, handshake, unknown }
