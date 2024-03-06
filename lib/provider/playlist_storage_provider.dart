import 'package:flutter/material.dart';
import 'package:ytp_new/model/local_storage.dart';
import 'package:ytp_new/model/playlist.dart';
import 'package:ytp_new/model/playlist_storage.dart';

class PlaylistStorageProvider extends ChangeNotifier {
  Set<Playlist> get playlists => PlaylistStorage.playlists;

  void add(Playlist pl) {
    PlaylistStorage.add(pl);
    notifyListeners();
    LocalStorage.savePlaylists();
  }

  //_ Singleton
  static final _provider = PlaylistStorageProvider._();
  factory PlaylistStorageProvider() => _provider;
  PlaylistStorageProvider._();
}
