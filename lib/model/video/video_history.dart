import 'package:ytp_new/model/video/video.dart';

class VideoHistory extends Video {
  final DateTime created;

  const VideoHistory({
    required this.created,
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
        'created': created.millisecondsSinceEpoch,
      };

  factory VideoHistory.fromMap(Map<String, dynamic> map) => VideoHistory(
        id: map['id'] as String,
        title: map['title'] as String,
        author: map['author'] as String,
        created: DateTime.fromMillisecondsSinceEpoch(map['created'] as int),
      );

  factory VideoHistory.fromVideo(Video video) => VideoHistory(
        created: DateTime.now(),
        id: video.id,
        title: video.title,
        author: video.author,
      );
}
