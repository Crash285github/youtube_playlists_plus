// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'title': title,
        'author': author,
        'thumbnail': thumbnail,
      };

  factory Video.fromMap(Map<String, dynamic> map) => Video(
        id: map['id'] as String,
        title: map['title'] as String,
        author: map['author'] as String,
        thumbnail: map['thumbnail'] as String,
      );

  String toJson() => json.encode(toMap());

  factory Video.fromJson(String source) =>
      Video.fromMap(json.decode(source) as Map<String, dynamic>);
}
