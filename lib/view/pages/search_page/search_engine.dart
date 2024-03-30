import 'package:youtube_explode_dart/youtube_explode_dart.dart'
    show PlaylistId, SearchPlaylist, TypeFilters;
import 'package:ytp_new/config.dart';
import 'package:ytp_new/extensions/extensions.dart';
import 'package:ytp_new/model/persistence.dart';
import 'package:ytp_new/model/playlist/playlist.dart';

class SearchEngine {
  /// Searches Youtube Playlists
  static Future<List<Playlist>> search(final String query) async =>
      (await _search(query))
        ..removeWhere(
          (final result) => PlaylistStorage.playlists.contains(result),
        );

  /// Searches Youtube Playlists, either with a link or plain text
  static Future<List<Playlist>> _search(final String query) async {
    if (query.isYoutubePlaylistLink()) {
      final pl = await _searchByLink(query);
      return pl == null ? [] : [pl];
    } else {
      return _searchByText(query);
    }
  }

  /// Searches a Youtube Playlist with a link
  static Future<Playlist?> _searchByLink(String link) async {
    final String? id = PlaylistId.parsePlaylistId(link);

    if (id == null) return null;

    try {
      final pl = AppConfig.youtube.playlists.get(id);
      final v = AppConfig.youtube.playlists.getVideos(id).first;
      await Future.wait([pl, v]);

      return Playlist(
        id: (await pl).id.toString(),
        title: (await pl).title,
        author: (await pl).author,
        thumbnail: (await v).thumbnails.mediumResUrl,
        description: "description",
        videos: [],
      );
    } catch (_) {}
    return null;
  }

  /// Searches Youtube Playlists with plain text
  static Future<List<Playlist>> _searchByText(final String query) async {
    final result = await AppConfig.youtube.search
        .searchContent("$query ", filter: TypeFilters.playlist);

    return (result).map((final result) {
      result as SearchPlaylist;

      return Playlist(
        id: result.id.toString(),
        title: result.title,
        thumbnail: result.thumbnails.last.url.toString(),
        author: "",
        description: "",
        videos: [],
      );
    }).toList();
  }
}
