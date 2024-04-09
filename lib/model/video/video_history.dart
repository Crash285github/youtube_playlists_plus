part of video;

class VideoHistory extends VideoChange {
  /// The time this `VideoHistory` has been made
  late final DateTime created;

  VideoHistory({
    required DateTime created,
    required super.type,
    required super.id,
    required super.playlistId,
    required super.title,
    required super.author,
  }) : super(thumbnail: "") {
    this.created =
        DateTime.fromMillisecondsSinceEpoch(created.millisecondsSinceEpoch);
  }

  /// Converts a `Video` to a `VideoHistory`
  factory VideoHistory.fromVideo(
    final Video video,
    final VideoChangeType type,
  ) =>
      VideoHistory(
        id: video.id,
        playlistId: video.playlistId,
        title: video.title,
        author: video.author,
        type: type,
        created: DateTime.now(),
      );

  @override
  bool operator ==(covariant VideoHistory other) =>
      super == (other) && created == other.created;

  @override
  int get hashCode => id.hashCode ^ created.hashCode;

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'playlistId': playlistId,
        'title': title,
        'author': author,
        'type': type.index,
        'created': created.millisecondsSinceEpoch,
      };

  factory VideoHistory.fromMap(final Map<String, dynamic> map) => VideoHistory(
        id: map['id'] as String,
        playlistId: map['playlistId'] as String,
        title: map['title'] as String,
        author: map['author'] as String,
        type: VideoChangeType.values[map['type'] as int],
        created: DateTime.fromMillisecondsSinceEpoch(map['created'] as int),
      );
}
