// ignore_for_file: public_member_api_docs, sort_constructors_first
class Playlist {
  final String id;
  final String title;
  final String author;
  final String description;
  final String thumbnail;

  Playlist({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.thumbnail,
  });

  @override
  bool operator ==(covariant Playlist other) =>
      identical(this, other) || other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Playlist(title: $title)';
}
