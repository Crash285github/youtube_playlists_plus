/// Represents a Youtube Media
abstract class Media {
  /// The unique identifier of this `Media`
  final String id;

  /// The title of this `Media`
  final String title;

  /// The author of this `Media`
  final String author;

  /// The thumbnail of this `Media`
  final String thumbnail;

  const Media({
    required this.id,
    required this.title,
    required this.author,
    required this.thumbnail,
  });
}
