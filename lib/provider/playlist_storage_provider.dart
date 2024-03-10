import 'package:flutter/material.dart';
import 'package:ytp_new/model/local_storage.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/model/playlist_storage.dart';

/// Communicates with [PlaylistStorage], and updates the UI
///
/// The ViewModel, called Provider here
class PlaylistStorageProvider extends ChangeNotifier {
  List<Playlist> get playlists => PlaylistStorage.playlists;

  /// Adds a `Playlist` to the Storage & notifies
  void add(final Playlist playlist) {
    PlaylistStorage.add(playlist);
    notifyListeners();
    Persistence.savePlaylists();
  }

  /// Removes a `Playlist` from the Storage & notifies
  bool remove(final Playlist playlist) {
    final bool result = PlaylistStorage.remove(playlist);
    notifyListeners();
    return result;
  }

  /// Notifies after calling a callback
  ///
  /// Used to update `Playlists` with
  void update(final void Function() fn) {
    fn();
    notifyListeners();
  }

  /// Returns a `Playlist` from the Storage with the given id
  /// if it exists
  Playlist? fromId(final String id) =>
      playlists.where((final playlist) => playlist.id == id).firstOrNull;

  //_ Singleton
  static final _provider = PlaylistStorageProvider._();
  factory PlaylistStorageProvider() => _provider;
  PlaylistStorageProvider._();
}
