import 'package:ytp_new/model/video/change_type.dart';
import 'package:ytp_new/model/video/video.dart';

class VideoChange extends Video {
  final VideoChangeType type;

  const VideoChange({
    required super.id,
    required super.title,
    required super.author,
    required super.thumbnail,
    required this.type,
  });

  bool get isAddition => type == VideoChangeType.addition;
  bool get isRemoval => type == VideoChangeType.removal;

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'title': title,
        'author': author,
        'thumbnail': thumbnail,
        'type': type.index,
      };

  factory VideoChange.fromMap(Map<String, dynamic> map) => VideoChange(
        id: map['id'] as String,
        title: map['title'] as String,
        author: map['author'] as String,
        thumbnail: map['thumbnail'] as String,
        type: VideoChangeType.values[map['type'] as int],
      );

  factory VideoChange.fromVideo(
          final Video video, final VideoChangeType type) =>
      VideoChange(
        id: video.id,
        title: video.title,
        author: video.author,
        thumbnail: video.thumbnail,
        type: type,
      );
}
