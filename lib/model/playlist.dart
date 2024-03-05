// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ytp_new/model/video.dart';

class Playlist {
  final String id;
  final String title;
  final String author;
  final String description;
  final String thumbnail;

  Playlist({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.thumbnail,
    required this.videos,
  });

  final List<Video> videos;

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
      };

  factory Playlist.fromMap(Map<String, dynamic> map) => Playlist(
        id: map['id'] as String,
        title: map['title'] as String,
        author: map['author'] as String,
        description: map['description'] as String,
        thumbnail: map['thumbnail'] as String,
        videos: List<Video>.from(
          (map['videos'] as List<int>).map<Video>(
            (x) => Video.fromMap(x as Map<String, dynamic>),
          ),
        ),
      );

  String toJson() => json.encode(toMap());

  factory Playlist.fromJson(String source) =>
      Playlist.fromMap(json.decode(source) as Map<String, dynamic>);
}
