import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:ytp_new/model/media.dart';
import 'package:ytp_new/model/playlist/playlist_changes.dart';
import 'package:ytp_new/model/playlist/playlist_history.dart';
import 'package:ytp_new/model/playlist/playlist_state.dart';
import 'package:ytp_new/model/video/change_type.dart';
import 'package:ytp_new/model/video/video.dart';
import 'package:ytp_new/model/video/video_change.dart';
import 'package:ytp_new/model/video/video_history.dart';

class Playlist extends Media with PlaylistChanges, PlaylistHistory {
  /// The description of this `Playlist`
  final String description;

  /// The state of this `Playlist`
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

  /// This `Playlist's` videos
  final List<Video> videos;

  /// Compares this `Playlist` with another
  ///
  /// Not the same as ==, since this checks the [videos] content as well
  bool compare(final Playlist other) {
    if (this != other) return false;
    return listEquals(other.videos, videos);
  }

  /// Gets the changes from a Playlist with the same id, but different [videos]
  ///
  /// Changes will be put into
  /// [this.additions], [this.removals] & [this.pendingHistory]
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
          (e) => VideoHistory.fromVideo(e, VideoChangeType.addition),
        ),
      )
      ..addAll(
        removed.map(
          (e) => VideoHistory.fromVideo(e, VideoChangeType.removal),
        ),
      );

    if (changes.isEmpty) {
      videos
        ..clear()
        ..addAll(other.videos);
    }
  }

  /// Does this `Playlist` have any changes
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
        'videos': videos.map((x) => x.toMap()).toList(),
        'history': savedHistory.map((x) => x.toMap()).toList()
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
      )..savedHistory.addAll(List<VideoHistory>.from(
          (map['history'] as List<dynamic>).map<VideoHistory>(
            (x) => VideoHistory.fromMap(x as Map<String, dynamic>),
          ),
        ));

  String toJson() => json.encode(toMap());

  factory Playlist.fromJson(String source) =>
      Playlist.fromMap(json.decode(source) as Map<String, dynamic>);
}
