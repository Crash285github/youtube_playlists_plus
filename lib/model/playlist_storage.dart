import 'package:ytp_new/model/playlist.dart';

class PlaylistStorage {
  static final Set<Playlist> _playlists = {};
  static Set<Playlist> get playlists => Set.unmodifiable(_playlists);

  static void add(Playlist pl) => _playlists.add(pl);
  static bool remove(Playlist pl) => _playlists.remove(pl);
}
