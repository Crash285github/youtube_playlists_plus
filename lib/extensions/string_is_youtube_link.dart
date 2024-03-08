import 'package:youtube_explode_dart/youtube_explode_dart.dart';

extension IsYoutubePlaylistLink on String {
  bool isYoutubePlaylistLink() =>
      PlaylistId.validatePlaylistId(PlaylistId.parsePlaylistId(this) ?? "");
}
