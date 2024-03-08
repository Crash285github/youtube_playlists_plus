import 'package:youtube_explode_dart/youtube_explode_dart.dart'
    show SearchList, SearchPlaylist, TypeFilters, YoutubeExplode;
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/model/playlist_storage.dart';

class SearchEngine {
  static Future<SearchList> search(String query) async {
    query += " ";
    var yt = YoutubeExplode();
    final result =
        await yt.search.searchContent(query, filter: TypeFilters.playlist);
    yt.close();

    return result;
  }

  static Future<List<Playlist>> searchPlaylists(String query) async {
    final results = await search(query);
    return results.map((final result) {
      result as SearchPlaylist;

      return Playlist(
        id: result.id.toString(),
        title: result.title,
        thumbnail: result.thumbnails.last.url.toString(),
        author: "",
        description: "",
        videos: [],
      );
    }).toList()
      ..removeWhere((element) => PlaylistStorage.playlists.contains(element));
  }
}
