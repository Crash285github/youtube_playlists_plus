import 'package:youtube_explode_dart/youtube_explode_dart.dart';

/// Check whether a String is a Youtube Playlist link
extension IsYoutubePlaylistLink on String {
  /// Checks whether a String is a Youtube Playlist's link
  bool isYoutubePlaylistLink() =>
      PlaylistId.validatePlaylistId(PlaylistId.parsePlaylistId(this) ?? "");
}
