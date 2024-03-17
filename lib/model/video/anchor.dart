// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart' show immutable;

enum AnchorPosition { start, middle, end }

@immutable
class Anchor {
  final String playlistId;
  final String videoId;
  final AnchorPosition position;
  final int offset;

  const Anchor({
    required this.playlistId,
    required this.videoId,
    required this.position,
    required this.offset,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'playlistId': playlistId,
        'videoId': videoId,
        'position': position.index,
        'offset': offset,
      };

  factory Anchor.fromMap(Map<String, dynamic> map) => Anchor(
        playlistId: map['playlistId'],
        videoId: map['videoId'],
        position: AnchorPosition.values[map['position'] as int],
        offset: map['offset'] as int,
      );

  String toJson() => json.encode(toMap());

  factory Anchor.fromJson(String source) =>
      Anchor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant Anchor other) {
    if (identical(this, other)) return true;

    return other.playlistId == playlistId && other.videoId == videoId;
  }

  @override
  int get hashCode => playlistId.hashCode ^ videoId.hashCode;
}
