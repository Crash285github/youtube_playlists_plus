part of playlist;

/// The history of a [Playlist]
mixin _PlaylistHistory {
  /// History that has been saved
  final List<VideoHistory> savedHistory = [];

  /// History that has not yet been saved
  final List<VideoHistory> pendingHistory = [];

  /// All the history
  ///
  /// Sorted by created
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

  /// Removes a [History]
  bool deleteHistory(final VideoHistory history) =>
      savedHistory.remove(history) || pendingHistory.remove(history);
}
