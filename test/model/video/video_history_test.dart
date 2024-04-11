import 'package:test/test.dart';
import 'package:ytp_new/model/video/video.dart';

void main() {
  group('VideoHistory', () {
    test('should create a VideoHistory instance', () {
      final videoHistory = VideoHistory(
        created: DateTime.now(),
        type: VideoChangeType.addition,
        id: 'videoId',
        playlistId: 'playlistId',
        title: 'Video Title',
        author: 'Video Author',
      );

      expect(videoHistory.created, isNotNull);
      expect(videoHistory.type, equals(VideoChangeType.addition));
      expect(videoHistory.id, equals('videoId'));
      expect(videoHistory.playlistId, equals('playlistId'));
      expect(videoHistory.title, equals('Video Title'));
      expect(videoHistory.author, equals('Video Author'));
    });

    test('should convert Video to VideoHistory', () {
      final video = Video(
        id: 'videoId',
        playlistId: 'playlistId',
        title: 'Video Title',
        author: 'Video Author',
        thumbnail: 'thumbnailUrl',
      );

      final videoHistory =
          VideoHistory.fromVideo(video, VideoChangeType.addition);

      expect(videoHistory.created, isNotNull);
      expect(videoHistory.type, equals(VideoChangeType.addition));
      expect(videoHistory.id, equals('videoId'));
      expect(videoHistory.playlistId, equals('playlistId'));
      expect(videoHistory.title, equals('Video Title'));
      expect(videoHistory.author, equals('Video Author'));
    });

    test('should compare two VideoHistory instances', () {
      final created = DateTime.now();

      final videoHistory1 = VideoHistory(
        created: created,
        type: VideoChangeType.addition,
        id: 'videoId',
        playlistId: 'playlistId',
        title: 'Video Title',
        author: 'Video Author',
      );

      final videoHistory2 = VideoHistory(
        created: created,
        type: VideoChangeType.addition,
        id: 'videoId',
        playlistId: 'playlistId',
        title: 'Video Title',
        author: 'Video Author',
      );

      expect(videoHistory1 == videoHistory2, isTrue);
    });

    test('should convert VideoHistory to a map', () {
      final videoHistory = VideoHistory(
        created: DateTime.now(),
        type: VideoChangeType.addition,
        id: 'videoId',
        playlistId: 'playlistId',
        title: 'Video Title',
        author: 'Video Author',
      );

      final map = videoHistory.toMap();

      expect(map['id'], equals('videoId'));
      expect(map['playlistId'], equals('playlistId'));
      expect(map['title'], equals('Video Title'));
      expect(map['author'], equals('Video Author'));
      expect(map['type'], equals(VideoChangeType.addition.index));
      expect(
          map['created'], equals(videoHistory.created.millisecondsSinceEpoch));
    });

    test('should create VideoHistory from a map', () {
      final map = {
        'id': 'videoId',
        'playlistId': 'playlistId',
        'title': 'Video Title',
        'author': 'Video Author',
        'type': VideoChangeType.addition.index,
        'created': DateTime.now().millisecondsSinceEpoch,
      };

      final videoHistory = VideoHistory.fromMap(map);

      expect(videoHistory.id, equals('videoId'));
      expect(videoHistory.playlistId, equals('playlistId'));
      expect(videoHistory.title, equals('Video Title'));
      expect(videoHistory.author, equals('Video Author'));
      expect(videoHistory.type, equals(VideoChangeType.addition));
      expect(
          videoHistory.created.millisecondsSinceEpoch, equals(map['created']));
    });
  });
}
