import 'package:ytp_new/model/playlist/playlist.dart';

/// Contains all Playlists
class PlaylistStorage {
  static final Set<Playlist> _playlists = {};

  /// Returns all `Playlists` as an unmodifiable List
  static Set<Playlist> get playlists => Set.unmodifiable(_playlists);

  /// Adds a `Playlist` to the Storage
  static void add(Playlist pl) => _playlists.add(pl);

  /// Removes a `Playlist` from the Storage
  static bool remove(Playlist pl) => _playlists.remove(pl);

  /// Replaces all `Playlists` from the Storage
  static void replace(List<Playlist> playlists) => _playlists
    ..clear()
    ..addAll(playlists);
}
