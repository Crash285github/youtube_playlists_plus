import 'package:flutter/material.dart';

/// Handles Playlist refreshing permissions
class FetchingProvider extends ChangeNotifier {
  final Set<String> _refreshing = {};
  int _downloadCount = 0;

  /// Set of [Playlist]s currently being refreshed
  Set<String> get refreshingList => Set.unmodifiable(_refreshing);

  /// Whether we are currently downloading new [Playlist]s
  bool get downloading => _downloadCount > 0;

  /// Increments the counter
  void incrementDownload() {
    _downloadCount++;
    notifyListeners();
  }

  /// Decrements the counter
  void decrementDownload() {
    _downloadCount--;
    notifyListeners();
  }

  /// Whether a [Playlist] is currently being refreshed or not
  bool isRefreshingPlaylist(final String playlistId) =>
      _refreshing.contains(playlistId);

  /// Add a [Playlist] to the [refreshingList]
  void add(final String playlistId) {
    _refreshing.add(playlistId);
    notifyListeners();
  }

  /// Remove a [Playlist] from the [refreshingList]
  bool remove(final String playlistId) {
    final bool result = _refreshing.remove(playlistId);
    notifyListeners();
    return result;
  }

  //_ Singleton
  static final _provider = FetchingProvider._();
  factory FetchingProvider() => _provider;
  FetchingProvider._();
}
