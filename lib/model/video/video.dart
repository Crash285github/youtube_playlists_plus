library video;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ytp_new/provider/anchor_storage_provider.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';

import 'package:ytp_new/service/download_service.dart';

part 'anchor.dart';
part 'video_change.dart';
part 'video_change_type.dart';
part 'video_history.dart';

class Video extends Media {
  /// The id of the [Playlist] this [Video] belongs to
  final String playlistId;

  Video({
    required super.id,
    required super.title,
    required super.author,
    required super.thumbnail,
    required this.playlistId,
  });

  /// The [Playlist] this [Video] belongs to
  Playlist get playlist => PlaylistStorageProvider().fromId(playlistId)!;

  /// The index of this [Video] in it's [Playlist]
  int get index => playlist.indexOf(this);

  /// Returns the [Anchor] of this [Video]
  Anchor? get anchor => AnchorStorageProvider().fromVideo(this);

  /// Is this [Video] anchored in it's correct position?
  bool get anchorInPlace => anchor?.index == index;

  @override
  String get link => "https://www.youtube.com/watch?v=$id";

  /// Downloads this [Video]
  Future<bool> download() async => await DownloadService.video(this);

  @override
  bool operator ==(covariant Video other) =>
      identical(this, other) || other.id == id;

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'playlistId': playlistId,
        'title': title,
        'author': author,
        'thumbnail': thumbnail,
      };

  factory Video.fromMap(final Map<String, dynamic> map) => Video(
        id: map['id'] as String,
        playlistId: map['playlistId'],
        title: map['title'] as String,
        author: map['author'] as String,
        thumbnail: map['thumbnail'] as String,
      );

  String toJson() => json.encode(toMap());

  factory Video.fromJson(final String source) =>
      Video.fromMap(json.decode(source) as Map<String, dynamic>);
}
