import 'package:flutter/material.dart';

/// Represents a `Playlist's` state
enum PlaylistState {
  unchecked(Colors.grey, Icons.refresh),
  checking(Colors.teal, Icons.update),
  unchanged(Colors.green, Icons.check_circle_outline),
  changed(Colors.amber, Icons.error_outline),
  missing(Colors.red, Icons.remove_circle_outline),
  ;

  final Color color;
  final IconData icon;

  const PlaylistState(this.color, this.icon);
}
