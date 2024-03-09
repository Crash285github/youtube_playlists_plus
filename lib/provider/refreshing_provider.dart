import 'package:flutter/material.dart';

/// Handles Playlist refreshing permissions
class RefreshingProvider extends ChangeNotifier {
  final List<String> _refreshing = [];
  List<String> get refreshingList => List.unmodifiable(_refreshing);

  bool isRefreshingPlaylist(final String playlistId) =>
      _refreshing.contains(playlistId);

  void add(final String playlistId) {
    _refreshing.add(playlistId);
    notifyListeners();
  }

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
