import 'package:flutter/material.dart';

/// Represents a `Playlist's` state
enum PlaylistState {
  unchecked(Colors.grey, Icon(Icons.refresh)),
  checking(Colors.teal, Icon(Icons.update)),
  unchanged(Colors.green, Icon(Icons.check_circle_outline)),
  changed(Colors.amber, Icon(Icons.error_outline)),
  missing(Colors.red, Icon(Icons.remove_circle_outline)),
  ;

  final Color color;
  final Icon icon;

  const PlaylistState(this.color, this.icon);
}
