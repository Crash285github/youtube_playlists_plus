part of extensions;

/// Check whether a String is a Youtube Playlist link
extension IsYoutubePlaylistLink on String {
  /// Checks whether a String is a Youtube Playlist's link
  bool isYoutubePlaylistLink() =>
      PlaylistId.validatePlaylistId(PlaylistId.parsePlaylistId(this) ?? "");
}
