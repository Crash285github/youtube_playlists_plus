library video;

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart'
    hide Video, Playlist;

import 'package:ytp_new/extensions/extensions.dart';
import 'package:ytp_new/provider/anchor_storage_provider.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/service/youtube_service.dart';

part 'anchor.dart';
part 'video_change.dart';
part 'video_change_type.dart';
part 'video_history.dart';

/// Represents a `Youtube Video`
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
  Future<bool> download() async {
    {
      final String? dir = await FilePicker.platform.getDirectoryPath();
      if (dir == null) return false;

      try {
        final streamManifest =
            await YoutubeService.youtube.videos.streamsClient.getManifest(id);

        final muxedStreaminfo = streamManifest.muxed.withHighestBitrate();

        final muxedStream =
            YoutubeService.youtube.videos.streamsClient.get(muxedStreaminfo);

        final file = File("$dir/${title.toFileName()}.mp4").openWrite();

        await muxedStream.pipe(file);
        await file.flush();
        await file.close();
      } catch (_) {
        return false;
      }

      return true;
    }
  }

  @override
  bool operator ==(covariant Video other) =>
      identical(this, other) || other.id == id;

  @override
  int get hashCode => id.hashCode;

  /// Converts this [Video] into a json-able [Map]
  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'playlistId': playlistId,
        'title': title,
        'author': author,
        'thumbnail': thumbnail,
      };

  /// Converts a `valid` [Map] into a [Video]
  factory Video.fromMap(final Map<String, dynamic> map) => Video(
        id: map['id'] as String,
        playlistId: map['playlistId'],
        title: map['title'] as String,
        author: map['author'] as String,
        thumbnail: map['thumbnail'] as String,
      );

  /// Converts this [Video] into a `json` formatted [String]
  String toJson() => json.encode(toMap());

  /// Converts a `valid` [String] into a [Video]
  factory Video.fromJson(final String source) =>
      Video.fromMap(json.decode(source) as Map<String, dynamic>);
}
