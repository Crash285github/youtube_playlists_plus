import 'package:flutter/material.dart';

@immutable
class Video {
  final String id;
  final String title;
  final String author;
  final String thumbnail;

  const Video({
    required this.id,
    required this.title,
    required this.author,
    required this.thumbnail,
  });

  @override
  bool operator ==(covariant Video other) =>
      identical(this, other) || other.id == id;

  @override
  int get hashCode => id.hashCode;
}
