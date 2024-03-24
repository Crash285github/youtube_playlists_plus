import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;
import 'package:ytp_new/model/playlist_storage.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/service/youtube_explode_service.dart';

class SharingService {
  static void receive() {
    ReceiveSharingIntent.getMediaStream().listen((event) async {
      if (event.isNotEmpty) {
        _handleIntent(event.first.path);
      }
    });

    ReceiveSharingIntent.getInitialMedia().then((value) async {
      if (value.isNotEmpty) {
        _handleIntent(value.first.path);
      }
      ReceiveSharingIntent.reset();
    });
  }

  static void _handleIntent(final String text) async {
    final String? id = yt.PlaylistId.parsePlaylistId(text);

    if (id == null) return null;
    if (PlaylistStorage.playlists
        .where((final playlist) => playlist.id == id)
        .isNotEmpty) return;

    final youtube = yt.YoutubeExplode();

    final pl = youtube.playlists.get(id);
    final v = youtube.playlists.getVideos(id).first;

    await Future.wait([pl, v]);

    //? private playlist shared
    if ((await pl).videoCount == null) return;

    final fetched = await YoutubeService.fetch(
      Playlist(
        id: (await pl).id.toString(),
        title: (await pl).title,
        author: (await pl).author,
        thumbnail: (await v).thumbnails.mediumResUrl,
        description: "description",
        videos: [],
      ),
    );

    PlaylistStorageProvider().add(fetched);

    youtube.close();
  }
}
