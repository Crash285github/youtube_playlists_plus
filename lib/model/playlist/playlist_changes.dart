import 'package:ytp_new/model/video/video_change.dart';

/// A `Playlist's` changes
mixin PlaylistChanges {
  final List<VideoChange> additions = [];
  final List<VideoChange> removals = [];

  List<VideoChange> get changes => (additions + removals)
    ..sort(
      (a, b) => a.title.compareTo(b.title),
    );
}
