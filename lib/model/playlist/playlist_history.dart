import 'package:ytp_new/model/video/video_history.dart';

/// A `Playlist's` history
mixin PlaylistHistory {
  /// History that is locally stored
  final List<VideoHistory> savedHistory = [];

  /// History that has not yet been stored locally
  final List<VideoHistory> pendingHistory = [];

  /// Shows all of history from most recent first
  List<VideoHistory> get history => (savedHistory + pendingHistory)
    ..sort((final a, final b) => b.created.compareTo(a.created));

  /// Clears pending & puts them all to saved
  void applyPendingHistory() {
    savedHistory.addAll(pendingHistory);
    pendingHistory.clear();
  }

  /// Removes a history
  bool removeHistory(final VideoHistory history) =>
      savedHistory.remove(history) || pendingHistory.remove(history);
}
