import 'package:flutter/material.dart';

/// The type of change a `Video` can be to the `Playlist`
enum VideoChangeType {
  /// The `Video` was added to the `Playlist`
  addition(Colors.green, Icons.add_circle_outline),

  /// The `Video` was removed from the `Playlist`
  removal(Colors.red, Icons.remove_circle_outline),
  ;

  final Color color;
  final IconData icon;

  const VideoChangeType(this.color, this.icon);
}
