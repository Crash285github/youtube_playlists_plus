import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;
import 'package:ytp_new/config.dart';
import 'package:ytp_new/model/persistence.dart';
import 'package:ytp_new/provider/fetching_provider.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/service/youtube_explode_service.dart';

class SharingService {
  static void receive() {
    ReceiveSharingIntent.getMediaStream().listen((event) async {
      if (event.isNotEmpty) {
        FetchingProvider().increaseDownload();
        await _handleIntent(event.first.path);
        FetchingProvider().decreaseDownload();
      }
    });

    ReceiveSharingIntent.getInitialMedia().then((value) async {
      if (value.isNotEmpty) {
        FetchingProvider().increaseDownload();
        await _handleIntent(value.first.path);
        FetchingProvider().decreaseDownload();
      }
      ReceiveSharingIntent.reset();
    });
  }

  static Future _handleIntent(final String text) async {
    final String? id = yt.PlaylistId.parsePlaylistId(text);

    if (id == null) return null;
    if (PlaylistStorage.playlists
        .where((final playlist) => playlist.id == id)
        .isNotEmpty) return;

    final pl = AppConfig.youtube.playlists.get(id);
    final v = AppConfig.youtube.playlists.getVideos(id).first;

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
  }
}
