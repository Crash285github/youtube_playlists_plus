import 'package:ytp_new/model/video/anchor.dart';

class AnchorStorage {
  static final List<Anchor> _anchors = [];

  static List<Anchor> get anchors => List.unmodifiable(_anchors);

  static void add(final Anchor anchor) => _anchors.add(anchor);

  static bool remove(final Anchor anchor) => _anchors.remove(anchor);
}
