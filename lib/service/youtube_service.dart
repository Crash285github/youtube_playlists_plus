import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:youtube_explode_dart/youtube_explode_dart.dart'
    hide Playlist, Video;
import 'package:ytp_new/model/playlist/playlist.dart';

/// Handles the communication with Youtube
class YoutubeService {
  /// The [YoutubeExplode] client used to fetch & download
  static final youtube = YoutubeExplode();

  /// Fetches a [Playlist]'s data
  static Future<Playlist> fetch(final Playlist playlist) async =>
      await Isolate.run(() => _fetch(playlist));

  static Future<Playlist> _fetch(final Playlist playlist) async {
    final metadata = await youtube.playlists
        .get(playlist.id)
        .timeout(const Duration(seconds: 20))
        .onError((error, _) {
      if (error is HandshakeException) {
        throw Exception(
          "Couldn't download [${playlist.title}]: HandshakeException.",
        );
      }
      if (error is TimeoutException) {
        throw Exception(
          "Downloading [${playlist.title}] timed out.",
        );
      }

      throw Exception(
        "Unknown error occurred while downloading [${playlist.title}].",
      );
    });

    final List<Video> videos = [];
    await for (final video in youtube.playlists.getVideos(playlist.id)) {
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
