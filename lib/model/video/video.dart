import 'dart:convert';

import 'package:ytp_new/model/media.dart';
import 'package:ytp_new/model/video/anchor.dart';
import 'package:ytp_new/service/download_service.dart';

class Video extends Media {
  Anchor? anchor;

  Video({
    required super.id,
    required super.title,
    required super.author,
    required super.thumbnail,
    this.anchor,
  });

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
        'title': title,
        'author': author,
        'thumbnail': thumbnail,
        'anchor': anchor?.toMap()
      };

  factory Video.fromMap(final Map<String, dynamic> map) => Video(
        id: map['id'] as String,
        title: map['title'] as String,
        author: map['author'] as String,
        thumbnail: map['thumbnail'] as String,
        anchor: map['anchor'] == null ? null : Anchor.fromMap(map['anchor']),
      );

  String toJson() => json.encode(toMap());

  factory Video.fromJson(final String source) =>
      Video.fromMap(json.decode(source) as Map<String, dynamic>);
}
