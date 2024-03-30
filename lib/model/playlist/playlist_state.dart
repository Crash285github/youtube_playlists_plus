part of playlist;

/// Represents a [Playlist]'s state
enum PlaylistState {
  /// The [Playlist] is currently being checked
  checking(
    Colors.teal,
    Icons.update,
    "Currently checking...",
  ),

  /// The [Playlist] has been checked & no changes were found
  unchanged(
    Colors.green,
    Icons.check_circle_outline,
    "No changes.",
  ),

  /// The [Playlist] has been checked & there were changes found
  changed(
    Colors.amber,
    Icons.error_outline,
    "Changes found.",
  ),

  /// The [Playlist] itself was not found during check
  missing(
    Colors.red,
    Icons.remove_circle_outline,
    "The Playlist has disappeared.",
  ),
  ;

  /// The color of the State for visualization
  final Color color;

  /// The Icon of the State for visualization
  final IconData icon;

  /// The message describing the State
  final String message;

  const PlaylistState(this.color, this.icon, this.message);
}
