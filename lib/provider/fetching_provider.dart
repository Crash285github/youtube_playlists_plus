import 'package:flutter/material.dart';

/// Handles Playlist refreshing permissions
class FetchingProvider extends ChangeNotifier {
  @visibleForTesting
  final Set<String> refreshing = {};

  @visibleForTesting
  int downloadCount = 0;

  /// Set of [Playlist]s currently being refreshed
  Set<String> get refreshingList => Set.unmodifiable(refreshing);

  /// Whether we are currently downloading new [Playlist]s
  bool get downloading => downloadCount > 0;

  /// Increments the counter
  void incrementDownload() {
    downloadCount++;
    notifyListeners();
  }

  /// Decrements the counter
  void decrementDownload() {
    if (downloadCount > 0) {
      downloadCount--;
      notifyListeners();
    }
  }

  /// Whether a [Playlist] is currently being refreshed or not
  bool isRefreshingPlaylist(final String playlistId) =>
      refreshing.contains(playlistId);

  /// Add a [Playlist] to the [refreshingList]
  bool add(final String playlistId) {
    final result = refreshing.add(playlistId);

    if (result) notifyListeners();

    return result;
  }

  /// Remove a [Playlist] from the [refreshingList]
  bool remove(final String playlistId) {
    final bool result = refreshing.remove(playlistId);

    if (result) notifyListeners();

    return result;
  }

  //_ Singleton
  static final _provider = FetchingProvider._();
  factory FetchingProvider() => _provider;
  FetchingProvider._();
}
