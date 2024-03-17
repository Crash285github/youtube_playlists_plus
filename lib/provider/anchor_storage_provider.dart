import 'package:flutter/material.dart';
import 'package:ytp_new/model/anchor_storage.dart';
import 'package:ytp_new/model/persistence.dart';
import 'package:ytp_new/model/video/anchor.dart';
import 'package:ytp_new/model/video/video.dart';

class AnchorStorageProvider extends ChangeNotifier {
  List<Anchor> get anchors => AnchorStorage.anchors;

  void replace(final List<Anchor> anchors) {
    AnchorStorage.replace(anchors);
    notifyListeners();
  }

  void change(final Anchor anchor) {
    AnchorStorage.change(anchor);
    notifyListeners();
    Persistence.saveAnchors();
  }

  bool remove(final Anchor anchor) {
    final result = AnchorStorage.remove(anchor);
    notifyListeners();
    Persistence.saveAnchors();
    return result;
  }

  /// Returns an [Anchor] belonging to a [Video]
  Anchor? fromVideo(final Video video) => anchors
      .where(
        (final anchor) =>
            anchor.playlistId == video.playlistId && anchor.videoId == video.id,
      )
      .firstOrNull;

  //_ Singleton
  static final _provider = AnchorStorageProvider._();
  factory AnchorStorageProvider() => _provider;
  AnchorStorageProvider._();
}
