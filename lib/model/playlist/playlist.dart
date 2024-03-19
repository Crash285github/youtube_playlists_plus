import 'dart:convert';

import 'package:ytp_new/model/media.dart';
import 'package:ytp_new/model/playlist/playlist_changes.dart';
import 'package:ytp_new/model/playlist/playlist_history.dart';
import 'package:ytp_new/model/playlist/playlist_planned.dart';
import 'package:ytp_new/model/playlist/playlist_state.dart';
import 'package:ytp_new/model/video/change_type.dart';
import 'package:ytp_new/model/video/video.dart';
import 'package:ytp_new/model/video/video_change.dart';
import 'package:ytp_new/model/video/video_history.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/provider/refreshing_provider.dart';
import 'package:ytp_new/service/youtube_explode_service.dart';

class Playlist extends Media
    with PlaylistChanges, PlaylistHistory, PlaylistPlanned {
  /// The description of this [Playlist]
  final String description;

  /// The state of this [Playlist]
  PlaylistState? state;

  Playlist({
    required super.id,
    required super.title,
    required super.author,
    required super.thumbnail,
    required this.description,
    required this.videos,
    this.state,
  });

  /// This [Playlist]'s videos
  final List<Video> videos;

  /// Gets the changes from a [Playlist] with the same id,
  /// but different [videos]
  ///
  /// Changes will be put into
  /// [additions], [removals] & [pendingHistory]
  void changesFrom(final Playlist other) {
    if (this != other) return;

    final Set<Video> added = other.videos.toSet().difference(videos.toSet());
    additions
      ..clear()
      ..addAll(
        added.map(
          (final video) =>
              VideoChange.fromVideo(video, VideoChangeType.addition),
        ),
      );

    final removed = videos.toSet().difference(other.videos.toSet());
    removals
      ..clear()
      ..addAll(
        removed.map(
          (final video) =>
              VideoChange.fromVideo(video, VideoChangeType.removal),
        ),
      );

    pendingHistory
      ..clear()
      ..addAll(
        added.map(
          (final video) =>
              VideoHistory.fromVideo(video, VideoChangeType.addition),
        ),
      )
      ..addAll(
        removed.map(
          (final video) =>
              VideoHistory.fromVideo(video, VideoChangeType.removal),
        ),
      );

    if (changes.isEmpty) {
      videos
        ..clear()
        ..addAll(other.videos);
    }
  }

  /// Refreshes this [Playlist]
  Future refresh() async {
    RefreshingProvider().add(id);

    try {
      PlaylistStorageProvider().update(() => state = PlaylistState.checking);

      final newPlaylist = await YoutubeService.download(this);

      PlaylistStorageProvider().update(() {
        changesFrom(newPlaylist);
        state = hasChanges ? PlaylistState.changed : PlaylistState.unchanged;
      });
    } catch (_) {
      PlaylistStorageProvider().update(() => state = null);
    } finally {
      RefreshingProvider().remove(id);
    }
  }

  /// Does this [Playlist] have any changes
  bool get hasChanges => changes.isNotEmpty;

  @override
  String get link => "https://www.youtube.com/playlist?list=$id";

  @override
  bool operator ==(covariant Playlist other) =>
      identical(this, other) || other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Playlist(title: $title)';

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'title': title,
        'author': author,
        'description': description,
        'thumbnail': thumbnail,
        'videos': [...videos.map((x) => x.toMap())],
        'history': [...savedHistory.map((x) => x.toMap())],
        'planned': planned,
      };

  factory Playlist.fromMap(Map<String, dynamic> map) => Playlist(
        id: map['id'] as String,
        title: map['title'] as String,
        author: map['author'] as String,
        description: map['description'] as String,
        thumbnail: map['thumbnail'] as String,
        videos: List<Video>.from(
          (map['videos'] as List<dynamic>).map<Video>(
            (x) => Video.fromMap(x as Map<String, dynamic>),
          ),
        ),
      )
        ..savedHistory.addAll(
          List<VideoHistory>.from(
            (map['history'] as List<dynamic>).map<VideoHistory>(
              (x) => VideoHistory.fromMap(x as Map<String, dynamic>),
            ),
          ),
        )
        ..planned.addAll(
          List<String>.from(
            (map['planned'] as List<dynamic>).map<String>((x) => x as String),
          ),
        );

  String toJson() => json.encode(toMap());

  factory Playlist.fromJson(String source) =>
      Playlist.fromMap(json.decode(source) as Map<String, dynamic>);
}
