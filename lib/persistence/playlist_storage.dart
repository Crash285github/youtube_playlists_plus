part of persistence;

/// Contains all Playlists
class PlaylistStorage {
  static final List<Playlist> _playlists = [];

  /// Returns all [Playlist]s as an unmodifiable List
  static List<Playlist> get playlists => List.unmodifiable(_playlists);

  /// Adds a [Playlist] to the Storage
  static void add(final Playlist pl) => _playlists.add(pl);

  /// Removes a [Playlist] from the Storage
  static bool remove(final Playlist pl) => _playlists.remove(pl);

  /// Replaces all [Playlist]s from the Storage
  static void replace(final List<Playlist> playlists) => _playlists
    ..clear()
    ..addAll(playlists);
}
