import 'package:ytp_new/model/video/video.dart';

mixin PlaylistChanges {
  final List<Video> additions = [];
  final List<Video> removals = [];

  List<Video> get changes => (additions + removals)
    ..sort(
      (a, b) => a.title.compareTo(b.title),
    );
}
