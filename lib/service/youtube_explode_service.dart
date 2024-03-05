import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;
import 'package:ytp_new/model/playlist.dart';
import 'package:ytp_new/model/video.dart';

class YoutubeExplodeService {
  static final youtube = yt.YoutubeExplode();

  static Future<Playlist> download(Playlist playlist) async {
    final metadata = await youtube.playlists.get(playlist.id);
    List<Video> videos = [];
    await for (var video in youtube.playlists.getVideos(playlist.id)) {
      videos.add(
        Video(
          id: video.id.toString(),
          title: video.title,
          author: video.author,
          thumbnail: video.thumbnails.mediumResUrl,
        ),
      );
    }

    return Playlist(
      id: playlist.id,
      title: metadata.title,
      author: metadata.author,
      description: metadata.description,
      thumbnail: playlist.thumbnail,
      videos: videos,
    );
  }
}
