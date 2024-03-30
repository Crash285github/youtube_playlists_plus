library playlist;

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:ytp_new/provider/fetching_provider.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/service/youtube_explode_service.dart';

export 'package:ytp_new/model/media.dart';
export 'package:ytp_new/model/video/video.dart';

part 'playlist_changes.dart';
part 'playlist_history.dart';
part 'playlist_planned.dart';
part 'playlist_state.dart';

/// Represents a `Youtube Playlist`
class Playlist extends Media
    with _PlaylistChanges, _PlaylistHistory, _PlaylistPlanned {
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
    required List<Video> videos,
    this.state,
  }) : _videos = videos;

  /// This [Playlist]'s videos
  List<Video> get videos => _videos;
  final List<Video> _videos;

  /// Gets the videos that are anchored
  List<Video> get anchoredVideos =>
      [..._videos.where((final video) => video.anchor != null)];

  /// Gets the changes from a [Playlist] with the same id,
  /// but different [_videos]
  ///
  /// Changes will be put into
  /// [additions], [removals] & [pendingHistory]
  void changesFrom(final Playlist other) {
    if (this != other) return;

    final Set<Video> added = other._videos.toSet().difference(_videos.toSet());
    additions
      ..clear()
      ..addAll(
        added.map(
          (final video) =>
              VideoChange.fromVideo(video, VideoChangeType.addition),
        ),
      );

    final removed = _videos.toSet().difference(other._videos.toSet());
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
      _videos
        ..clear()
        ..addAll(other._videos);
    }
  }

  /// Refreshes this [Playlist]
  Future refresh() async {
    FetchingProvider().add(id);

    try {
      PlaylistStorageProvider().update(() => state = PlaylistState.checking);

      final newPlaylist = await YoutubeService.fetch(this);
      if (newPlaylist.length != 0) {
        thumbnail = newPlaylist[0].thumbnail;
        title = newPlaylist.title;
        author = newPlaylist.author;
      }

      PlaylistStorageProvider().update(
        () {
          changesFrom(newPlaylist);
          state = hasChanges ? PlaylistState.changed : PlaylistState.unchanged;
        },
        save: true,
      );
    } on Exception {
      PlaylistStorageProvider().update(() => state = null);
    } finally {
      FetchingProvider().remove(id);
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

  /// Returns a [Video] at position `i` in this [Playlist]
  Video operator [](final int i) => _videos[i];

  /// Returns the number of [Video]s in this [Playlist]
  int get length => _videos.length;

  /// Returns `true` if this [Playlist] contains `video`
  bool contains(final Video video) => _videos.contains(video);

  /// Returns the index of `video` in this [Playlist]
  int indexOf(final Video video) => _videos.indexOf(video);

  /// Adds a [Video] to this [Playlist]
  void add(final Video video) => _videos.add(video);

  /// Removes a [Video] from this [Playlist]
  bool remove(final Video video) => _videos.remove(video);

  /// Converts this [Playlist] into a json-able [Map]
  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'title': title,
        'author': author,
        'description': description,
        'thumbnail': thumbnail,
        'videos': [..._videos.map((final video) => video.toMap())],
        'history': [...savedHistory.map((final history) => history.toMap())],
        'planned': planned,
      };

  /// Converts a `valid` [Map] into a [Playlist]
  factory Playlist.fromMap(Map<String, dynamic> map) => Playlist(
        id: map['id'] as String,
        title: map['title'] as String,
        author: map['author'] as String,
        description: map['description'] as String,
        thumbnail: map['thumbnail'] as String,
        videos: List<Video>.from(
          (map['videos'] as List<dynamic>).map<Video>(
            (final map) => Video.fromMap(map as Map<String, dynamic>),
          ),
        ),
      )
        ..savedHistory.addAll(
          List<VideoHistory>.from(
            (map['history'] as List<dynamic>).map<VideoHistory>(
              (final map) => VideoHistory.fromMap(map as Map<String, dynamic>),
            ),
          ),
        )
        ..planned.addAll(
          List<String>.from(
            (map['planned'] as List<dynamic>)
                .map<String>((final map) => map as String),
          ),
        );

  /// Converts this [Playlist] into a `json` formatted [String]
  String toJson() => json.encode(toMap());

  /// Converts a `valid` [String] into a [Playlist]
  factory Playlist.fromJson(final String source) =>
      Playlist.fromMap(json.decode(source) as Map<String, dynamic>);
}
