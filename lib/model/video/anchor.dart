// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart' show immutable;

enum AnchorPosition { start, middle, end }

@immutable
class Anchor {
  final AnchorPosition position;
  final int offset;

  const Anchor({
    required this.position,
    required this.offset,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'position': position.index,
        'offset': offset,
      };

  factory Anchor.fromMap(Map<String, dynamic> map) => Anchor(
        position: AnchorPosition.values[map['position'] as int],
        offset: map['offset'] as int,
      );

  String toJson() => json.encode(toMap());

  factory Anchor.fromJson(String source) =>
      Anchor.fromMap(json.decode(source) as Map<String, dynamic>);
}
