import 'package:ytp_new/model/video/anchor.dart';

class AnchorStorage {
  static final List<Anchor> _anchors = [];

  /// Conatins all [Anchor]s
  static List<Anchor> get anchors => List.unmodifiable(_anchors);

  /// Replaces or adds an [Anchor] to the list
  static void change(final Anchor anchor) => _anchors
    ..remove(anchor)
    ..add(anchor);

  /// Removes an [Anchor] from the list
  static bool remove(final Anchor anchor) => _anchors.remove(anchor);

  /// Replaces all the anchors with the given list
  static void replace(final List<Anchor> anchors) => _anchors
    ..clear()
    ..addAll(anchors);
}
