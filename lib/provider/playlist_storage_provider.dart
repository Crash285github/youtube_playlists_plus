import 'package:flutter/material.dart';
import 'package:ytp_new/model/local_storage.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/model/playlist_storage.dart';

/// Communicates with [PlaylistStorage], and updates the UI
///
/// The ViewModel, called Provider here
class PlaylistStorageProvider extends ChangeNotifier {
  List<Playlist> get playlists => PlaylistStorage.playlists;

  void add(Playlist pl) {
    PlaylistStorage.add(pl);
    notifyListeners();
    LocalStorage.savePlaylists();
  }

  bool remove(Playlist pl) {
    final bool result = PlaylistStorage.remove(pl);
    notifyListeners();
    return result;
  }

  void update(void Function() fn) {
    fn();
    notifyListeners();
  }

  Playlist? fromId(final String id) =>
      playlists.where((final playlist) => playlist.id == id).firstOrNull;

  //_ Singleton
  static final _provider = PlaylistStorageProvider._();
  factory PlaylistStorageProvider() => _provider;
  PlaylistStorageProvider._();
}
