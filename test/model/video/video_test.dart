import 'package:test/test.dart';
import 'package:ytp_new/model/video/video.dart';

void main() {
  group('Video', () {
    late Video video;

    setUp(() {
      video = Video(
        id: 'video_id',
        title: 'Video Title',
        author: 'Video Author',
        thumbnail: 'thumbnail_url',
        playlistId: 'playlist_id',
      );
    });

    test('should have correct properties', () {
      expect(video.id, 'video_id');
      expect(video.title, 'Video Title');
      expect(video.author, 'Video Author');
      expect(video.thumbnail, 'thumbnail_url');
      expect(video.playlistId, 'playlist_id');
    });

    test('should have correct link', () {
      expect(video.link, 'https://www.youtube.com/watch?v=video_id');
    });

    test('should be equal to another video with the same id', () {
      final otherVideo = Video(
        id: 'video_id',
        title: 'Other Video Title',
        author: 'Other Video Author',
        thumbnail: 'other_thumbnail_url',
        playlistId: 'other_playlist_id',
      );

      expect(video == otherVideo, true);
    });

    test('should convert to map correctly', () {
      final videoMap = video.toMap();

      expect(videoMap['id'], 'video_id');
      expect(videoMap['playlistId'], 'playlist_id');
      expect(videoMap['title'], 'Video Title');
      expect(videoMap['author'], 'Video Author');
      expect(videoMap['thumbnail'], 'thumbnail_url');
    });

    test('should convert to json correctly', () {
      final jsonString = video.toJson();

      expect(jsonString,
          '{"id":"video_id","playlistId":"playlist_id","title":"Video Title","author":"Video Author","thumbnail":"thumbnail_url"}');
    });

    test('should be created from map correctly', () {
      final videoMap = {
        'id': 'video_id',
        'playlistId': 'playlist_id',
        'title': 'Video Title',
        'author': 'Video Author',
        'thumbnail': 'thumbnail_url',
      };

      final createdVideo = Video.fromMap(videoMap);

      expect(createdVideo.id, 'video_id');
      expect(createdVideo.playlistId, 'playlist_id');
      expect(createdVideo.title, 'Video Title');
      expect(createdVideo.author, 'Video Author');
      expect(createdVideo.thumbnail, 'thumbnail_url');
    });

    test('should be created from json correctly', () {
      const jsonString =
          '{"id":"video_id","playlistId":"playlist_id","title":"Video Title","author":"Video Author","thumbnail":"thumbnail_url"}';

      final createdVideo = Video.fromJson(jsonString);

      expect(createdVideo.id, 'video_id');
      expect(createdVideo.playlistId, 'playlist_id');
      expect(createdVideo.title, 'Video Title');
      expect(createdVideo.author, 'Video Author');
      expect(createdVideo.thumbnail, 'thumbnail_url');
    });
  });
}
