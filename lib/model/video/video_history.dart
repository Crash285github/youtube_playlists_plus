import 'package:ytp_new/model/video/history_type.dart';
import 'package:ytp_new/model/video/video.dart';

class VideoHistory extends Video {
  final DateTime created;
  final VideoHistoryType type;

  const VideoHistory({
    required this.created,
    required this.type,
    required super.id,
    required super.title,
    required super.author,
  }) : super(thumbnail: "");

  @override
  bool operator ==(covariant VideoHistory other) =>
      identical(this, other) || (other.id == id && other.created == created);

  @override
  int get hashCode => id.hashCode ^ created.hashCode;

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'title': title,
        'author': author,
        'type': type.index,
        'created': created.millisecondsSinceEpoch,
      };

  factory VideoHistory.fromMap(Map<String, dynamic> map) => VideoHistory(
        id: map['id'] as String,
        title: map['title'] as String,
        author: map['author'] as String,
        type: VideoHistoryType.values[map['type'] as int],
        created: DateTime.fromMillisecondsSinceEpoch(map['created'] as int),
      );

  factory VideoHistory.fromVideo(Video video, VideoHistoryType type) =>
      VideoHistory(
        id: video.id,
        title: video.title,
        author: video.author,
        type: type,
        created: DateTime.now(),
      );
}
