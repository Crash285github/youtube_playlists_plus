part of video;

enum AnchorPosition { start, middle, end }

@immutable
class Anchor {
  /// The id of the [Playlist] this [Anchor] belongs to
  final String playlistId;

  /// The id of the [Video] this [Anchor] belongs to
  final String videoId;

  /// The position of this [Anchor]
  final AnchorPosition position;

  /// The offset of this [Anchor]
  final int offset;

  /// The index this [Anchor] represents in it's [Playlist]
  int get index => switch (position) {
        AnchorPosition.start => offset,
        AnchorPosition.middle => _playlistLength ~/ 2 + offset,
        AnchorPosition.end => _playlistLength + offset,
      };

  int get _playlistLength =>
      PlaylistStorageProvider().fromId(playlistId)!.length - 1;

  const Anchor({
    required this.playlistId,
    required this.videoId,
    required this.position,
    required this.offset,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'playlistId': playlistId,
        'videoId': videoId,
        'position': position.index,
        'offset': offset,
      };

  factory Anchor.fromMap(Map<String, dynamic> map) => Anchor(
        playlistId: map['playlistId'],
        videoId: map['videoId'],
        position: AnchorPosition.values[map['position'] as int],
        offset: map['offset'] as int,
      );

  String toJson() => json.encode(toMap());

  factory Anchor.fromJson(String source) =>
      Anchor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant Anchor other) {
    if (identical(this, other)) return true;

    return other.playlistId == playlistId && other.videoId == videoId;
  }

  @override
  int get hashCode => playlistId.hashCode ^ videoId.hashCode;
}
