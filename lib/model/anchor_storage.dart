import 'package:ytp_new/model/video/anchor.dart';

class AnchorStorage {
  static final List<Anchor> _anchors = [];

  static List<Anchor> get anchors => List.unmodifiable(_anchors);

  static void change(final Anchor anchor) => _anchors
    ..remove(anchor)
    ..add(anchor);

  static bool remove(final Anchor anchor) => _anchors.remove(anchor);

  static void replace(final List<Anchor> anchors) => _anchors
    ..clear()
    ..addAll(anchors);
}
