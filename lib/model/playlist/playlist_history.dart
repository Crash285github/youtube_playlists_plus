import 'package:ytp_new/model/video/video_history.dart';

/// A `Playlist's` history
mixin PlaylistHistory {
  /// History that is locally stored
  final List<VideoHistory> savedHistory = [];

  /// History that has not yet been stored locally
  final List<VideoHistory> pendingHistory = [];

  /// Shows all of history from most recent first
  List<VideoHistory> get history => (savedHistory + pendingHistory)
    ..sort((final fst, final snd) => snd.created.compareTo(fst.created));

  /// Moves a [VideoHistory] to saved
  void pendingToSaved(final VideoHistory history) {
    final toMove = pendingHistory
        .where((final pending) => history.id == pending.id)
        .firstOrNull;

    if (toMove != null) {
      savedHistory.add(toMove);
      pendingHistory.remove(toMove);
    }
  }

  /// Removes a history
  bool removeHistory(final VideoHistory history) =>
      savedHistory.remove(history) || pendingHistory.remove(history);
}
