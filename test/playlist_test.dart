import 'package:test/test.dart';
import 'package:ytp_new/model/playlist/playlist.dart';

void main() {
  group('Playlist', () {
    late Playlist playlist;
    late List<Video> videos;

    setUp(() {
      videos = [
        Video(
            playlistId: 'playlist_id',
            id: '1',
            title: 'Video 1',
            author: 'Author 1',
            thumbnail: 'thumbnail1'),
        Video(
            playlistId: 'playlist_id',
            id: '2',
            title: 'Video 2',
            author: 'Author 2',
            thumbnail: 'thumbnail2'),
        Video(
            playlistId: 'playlist_id',
            id: '3',
            title: 'Video 3',
            author: 'Author 3',
            thumbnail: 'thumbnail3'),
      ];

      playlist = Playlist(
        id: 'playlist_id',
        title: 'Playlist Title',
        author: 'Playlist Author',
        thumbnail: 'playlist_thumbnail',
        description: 'Playlist Description',
        videos: videos,
      );
    });

    test('should return the correct playlist properties', () {
      expect(playlist.id, 'playlist_id');
      expect(playlist.title, 'Playlist Title');
      expect(playlist.author, 'Playlist Author');
      expect(playlist.thumbnail, 'playlist_thumbnail');
      expect(playlist.description, 'Playlist Description');
      expect(playlist.videos, videos);
    });

    test('should return the correct number of videos in the playlist', () {
      expect(playlist.length, 3);
    });

    test('should add a video to the playlist', () {
      final newVideo = Video(
          playlistId: 'playlist_id',
          id: '4',
          title: 'Video 4',
          author: 'Author 4',
          thumbnail: 'thumbnail4');
      playlist.add(newVideo);

      expect(playlist.length, 4);
      expect(playlist.contains(newVideo), isTrue);
    });

    test('should remove a video from the playlist', () {
      final videoToRemove = videos[0];
      final removed = playlist.remove(videoToRemove);

      expect(removed, isTrue);
      expect(playlist.length, 2);
      expect(playlist.contains(videoToRemove), isFalse);
    });

    test('should get the index of a video in the playlist', () {
      final videoToFind = videos[1];
      final index = playlist.indexOf(videoToFind);

      expect(index, 1);
    });

    test('should get a video at a specific position in the playlist', () {
      final video = playlist[2];

      expect(video, videos[2]);
    });

    test('should convert the playlist to a json-able map', () {
      final playlistMap = playlist.toMap();

      expect(playlistMap['id'], 'playlist_id');
      expect(playlistMap['title'], 'Playlist Title');
      expect(playlistMap['author'], 'Playlist Author');
      expect(playlistMap['description'], 'Playlist Description');
      expect(playlistMap['thumbnail'], 'playlist_thumbnail');
      expect(playlistMap['videos'], videos.map((v) => v.toMap()).toList());
    });

    test('should convert the playlist to a json string', () {
      final jsonString = playlist.toJson();

      expect(jsonString, isA<String>());
    });

    test('should create a playlist from a valid map', () {
      final videoHistory = videos
          .map((v) => VideoHistory.fromVideo(v, VideoChangeType.addition))
          .toList();

      final playlistMap = {
        'id': 'playlist_id',
        'title': 'Playlist Title',
        'author': 'Playlist Author',
        'description': 'Playlist Description',
        'thumbnail': 'playlist_thumbnail',
        'videos': videos.map((v) => v.toMap()).toList(),
        'history': videoHistory.map((e) => e.toMap()).toList(),
        'planned': ["video_id_1", "video_id_2"]
      };

      final newPlaylist = Playlist.fromMap(playlistMap);

      expect(newPlaylist.id, 'playlist_id');
      expect(newPlaylist.title, 'Playlist Title');
      expect(newPlaylist.author, 'Playlist Author');
      expect(newPlaylist.description, 'Playlist Description');
      expect(newPlaylist.thumbnail, 'playlist_thumbnail');
      expect(newPlaylist.videos, videos);
      expect(newPlaylist.savedHistory, videoHistory);
      expect(newPlaylist.planned, ["video_id_1", "video_id_2"]);
    });

    test('should create a playlist from a valid json string', () {
      const jsonString = '''
        {
          "id": "playlist_id",
          "title": "Playlist Title",
          "author": "Playlist Author",
          "description": "Playlist Description",
          "thumbnail": "playlist_thumbnail",
          "videos": [
            {"playlistId": "playlist_id","id": "1", "title": "Video 1", "author": "Author 1", "thumbnail": "thumbnail1"},
            {"playlistId": "playlist_id","id": "2", "title": "Video 2", "author": "Author 2", "thumbnail": "thumbnail2"},
            {"playlistId": "playlist_id","id": "3", "title": "Video 3", "author": "Author 3", "thumbnail": "thumbnail3"}
          ],
          "history": [
            {"playlistId": "playlist_id","id": "1", "title": "Video 1", "author": "Author 1", "type": 0, "created": 0},
            {"playlistId": "playlist_id","id": "2", "title": "Video 2", "author": "Author 2", "type": 0, "created": 0},
            {"playlistId": "playlist_id","id": "3", "title": "Video 3", "author": "Author 3", "type": 0, "created": 0}
          ],
          "planned": ["video_id_1", "video_id_2"]
        }
      ''';

      final newPlaylist = Playlist.fromJson(jsonString);

      expect(newPlaylist.id, 'playlist_id');
      expect(newPlaylist.title, 'Playlist Title');
      expect(newPlaylist.author, 'Playlist Author');
      expect(newPlaylist.description, 'Playlist Description');
      expect(newPlaylist.thumbnail, 'playlist_thumbnail');
      expect(newPlaylist.videos, videos);
      expect(newPlaylist.planned, ["video_id_1", "video_id_2"]);
    });
  });
}
