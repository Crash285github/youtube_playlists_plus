import 'package:flutter/material.dart';

/// Handles Playlist refreshing permissions
class RefreshingProvider extends ChangeNotifier {
  final List<String> _refreshing = [];

  /// List of `Playlists` currently being refreshed
  List<String> get refreshingList => List.unmodifiable(_refreshing);

  /// Whether a `Playlist` is currently being refreshed or not
  bool isRefreshingPlaylist(final String playlistId) =>
      _refreshing.contains(playlistId);

  /// Add a `Playlist` to the [refreshingList]
  void add(final String playlistId) {
    _refreshing.add(playlistId);
    notifyListeners();
  }

  /// Remove a `Playlist` from the [refreshingList]
  bool remove(final String playlistId) {
    final bool result = _refreshing.remove(playlistId);
    notifyListeners();
    return result;
  }

  //_ Singleton
  static final _provider = RefreshingProvider._();
  factory RefreshingProvider() => _provider;
  RefreshingProvider._();
}
