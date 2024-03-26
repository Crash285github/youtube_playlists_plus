part of playlist;

/// Represents a [Playlist]'s state
enum PlaylistState {
  /// The [Playlist] is currently being checked
  checking(Colors.teal, Icons.update),

  /// The [Playlist] has been checked & no changes were found
  unchanged(Colors.green, Icons.check_circle_outline),

  /// The [Playlist] has been checked & there were changes found
  changed(Colors.amber, Icons.error_outline),

  /// The [Playlist] itself was not found during check
  missing(Colors.red, Icons.remove_circle_outline),
  ;

  final Color color;
  final IconData icon;

  const PlaylistState(this.color, this.icon);
}
