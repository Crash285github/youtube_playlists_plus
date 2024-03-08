import 'package:ytp_new/model/video.dart';

mixin PlaylistHistory {
  final List<Video> history = [
    const Video(
        id: "id", title: "title", author: "author", thumbnail: "thumbnail")
  ];
}
