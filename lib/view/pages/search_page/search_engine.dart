import 'package:youtube_explode_dart/youtube_explode_dart.dart'
    show PlaylistId, SearchPlaylist, TypeFilters, YoutubeExplode;
import 'package:ytp_new/extensions/string_is_youtube_link.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/model/playlist_storage.dart';

class SearchEngine {
  /// Searches Youtube Playlists
  static Future<List<Playlist>> search(String query) async =>
      (await _search(query))
        ..removeWhere((element) => PlaylistStorage.playlists.contains(element));

  /// Searches Youtube Playlists, either with a link or plain text
  static Future<List<Playlist>> _search(String query) async {
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
    var yt = YoutubeExplode();

    final pl = yt.playlists.get(id);
    final v = yt.playlists.getVideos(id).first;

    await Future.wait([pl, v]);

    return Playlist(
      id: (await pl).id.toString(),
      title: (await pl).title,
      author: (await pl).author,
      thumbnail: (await v).thumbnails.mediumResUrl,
      description: "description",
      videos: [],
    );
  }

  /// Searches Youtube Playlists with plain text
  static Future<List<Playlist>> _searchByText(String query) async {
    query += " ";
    var yt = YoutubeExplode();
    final result =
        await yt.search.searchContent(query, filter: TypeFilters.playlist);
    yt.close();

    return result.map((final result) {
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
