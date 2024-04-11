import 'package:test/test.dart';
import 'package:ytp_new/model/video/video.dart';

void main() {
  group('VideoChange', () {
    test('isAddition should return true when type is VideoChangeType.addition',
        () {
      final videoChange = VideoChange(
        id: '1',
        playlistId: 'playlist1',
        title: 'Video 1',
        author: 'Author 1',
        thumbnail: 'thumbnail1',
        type: VideoChangeType.addition,
      );

      expect(videoChange.isAddition, isTrue);
    });

    test(
        'isAddition should return false when type is not VideoChangeType.addition',
        () {
      final videoChange = VideoChange(
        id: '1',
        playlistId: 'playlist1',
        title: 'Video 1',
        author: 'Author 1',
        thumbnail: 'thumbnail1',
        type: VideoChangeType.removal,
      );

      expect(videoChange.isAddition, isFalse);
    });

    test('isRemoval should return true when type is VideoChangeType.removal',
        () {
      final videoChange = VideoChange(
        id: '1',
        playlistId: 'playlist1',
        title: 'Video 1',
        author: 'Author 1',
        thumbnail: 'thumbnail1',
        type: VideoChangeType.removal,
      );

      expect(videoChange.isRemoval, isTrue);
    });

    test(
        'isRemoval should return false when type is not VideoChangeType.removal',
        () {
      final videoChange = VideoChange(
        id: '1',
        playlistId: 'playlist1',
        title: 'Video 1',
        author: 'Author 1',
        thumbnail: 'thumbnail1',
        type: VideoChangeType.addition,
      );

      expect(videoChange.isRemoval, isFalse);
    });

    test(
        'VideoChange.fromVideo should create a VideoChange instance with the correct properties',
        () {
      final video = Video(
        id: '1',
        playlistId: 'playlist1',
        title: 'Video 1',
        author: 'Author 1',
        thumbnail: 'thumbnail1',
      );

      final videoChange =
          VideoChange.fromVideo(video, VideoChangeType.addition);

      expect(videoChange.id, equals(video.id));
      expect(videoChange.playlistId, equals(video.playlistId));
      expect(videoChange.title, equals(video.title));
      expect(videoChange.author, equals(video.author));
      expect(videoChange.thumbnail, equals(video.thumbnail));
      expect(videoChange.type, equals(VideoChangeType.addition));
    });
  });
}
