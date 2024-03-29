part of video;

class VideoChange extends Video {
  /// The type of change
  final VideoChangeType type;

  VideoChange({
    required super.id,
    required super.playlistId,
    required super.title,
    required super.author,
    required super.thumbnail,
    required this.type,
  });

  /// Has this [Video] been added to its [Playlist]
  bool get isAddition => type == VideoChangeType.addition;

  /// Has this [Video] been removed from its [Playlist]
  bool get isRemoval => type == VideoChangeType.removal;

  /// Converts a [Video] to a [VideoChange]
  factory VideoChange.fromVideo(
    final Video video,
    final VideoChangeType type,
  ) =>
      VideoChange(
        id: video.id,
        playlistId: video.playlistId,
        title: video.title,
        author: video.author,
        thumbnail: video.thumbnail,
        type: type,
      );
}
