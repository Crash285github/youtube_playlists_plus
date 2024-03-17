import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ytp_new/model/media.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/service/download_service.dart';

@immutable
class Video extends Media {
  final String playlistId;

  const Video({
    required super.id,
    required super.title,
    required super.author,
    required super.thumbnail,
    required this.playlistId,
  });

  /// The [Playlist] this [Video] belongs to
  Playlist get playlist => PlaylistStorageProvider().fromId(playlistId)!;

  /// The position of this [Video] in it's [Playlist]
  int get position => playlist.videos.indexOf(this) + 1;

  @override
  String get link => "https://www.youtube.com/watch?v=$id";

  /// Downloads this [Video]
  Future<bool> download() async => await DownloadService.download(this);

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
