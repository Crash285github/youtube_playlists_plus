import 'package:url_launcher/url_launcher.dart';

/// Represents a Youtube Media
abstract class Media {
  /// The unique identifier of this `Media`
  final String id;

  /// The title of this `Media`
  String title;

  /// The author of this `Media`
  String author;

  /// The thumbnail of this `Media`
  String thumbnail;

  Media({
    required this.id,
    required this.title,
    required this.author,
    required this.thumbnail,
  });

  /// The Youtube Link of this `Media`
  String get link => throw UnimplementedError();

  /// Opens a `Media` externally on `Youtube`
  Future<bool> open() async => await launchUrl(Uri.parse(link));
}
