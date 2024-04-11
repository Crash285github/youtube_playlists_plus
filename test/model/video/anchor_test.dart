import 'package:test/test.dart';
import 'package:ytp_new/model/video/video.dart';

void main() {
  group('Anchor', () {
    const playlistId = 'playlistId';
    const videoId = 'videoId';
    const position = AnchorPosition.start;
    const offset = 0;

    test('should create an Anchor instance', () {
      const anchor = Anchor(
        playlistId: playlistId,
        videoId: videoId,
        position: position,
        offset: offset,
      );

      expect(anchor.playlistId, equals(playlistId));
      expect(anchor.videoId, equals(videoId));
      expect(anchor.position, equals(position));
      expect(anchor.offset, equals(offset));
    });

    test('should convert Anchor to Map', () {
      const anchor = Anchor(
        playlistId: playlistId,
        videoId: videoId,
        position: position,
        offset: offset,
      );

      final map = anchor.toMap();

      expect(map['playlistId'], equals(playlistId));
      expect(map['videoId'], equals(videoId));
      expect(map['position'], equals(position.index));
      expect(map['offset'], equals(offset));
    });

    test('should convert Map to Anchor', () {
      final map = <String, dynamic>{
        'playlistId': playlistId,
        'videoId': videoId,
        'position': position.index,
        'offset': offset,
      };

      final anchor = Anchor.fromMap(map);

      expect(anchor.playlistId, equals(playlistId));
      expect(anchor.videoId, equals(videoId));
      expect(anchor.position, equals(position));
      expect(anchor.offset, equals(offset));
    });

    test('should convert Anchor to JSON', () {
      const anchor = Anchor(
        playlistId: playlistId,
        videoId: videoId,
        position: position,
        offset: offset,
      );

      final json = anchor.toJson();

      expect(
          json,
          equals(
              '{"playlistId":"$playlistId","videoId":"$videoId","position":0,"offset":$offset}'));
    });

    test('should convert JSON to Anchor', () {
      const json =
          '{"playlistId":"$playlistId","videoId":"$videoId","position":0,"offset":$offset}';

      final anchor = Anchor.fromJson(json);

      expect(anchor.playlistId, equals(playlistId));
      expect(anchor.videoId, equals(videoId));
      expect(anchor.position, equals(position));
      expect(anchor.offset, equals(offset));
    });

    test('should calculate index correctly', () {
      const anchor = Anchor(
        playlistId: playlistId,
        videoId: videoId,
        position: position,
        offset: offset,
      );

      expect(anchor.index, equals(offset));
    });

    test('should check equality correctly', () {
      const anchor1 = Anchor(
        playlistId: playlistId,
        videoId: videoId,
        position: position,
        offset: offset,
      );

      const anchor2 = Anchor(
        playlistId: playlistId,
        videoId: videoId,
        position: position,
        offset: offset,
      );

      expect(anchor1 == anchor2, isTrue);
    });

    test('should calculate hashCode correctly', () {
      const anchor = Anchor(
        playlistId: playlistId,
        videoId: videoId,
        position: position,
        offset: offset,
      );

      final hashCode = playlistId.hashCode ^ videoId.hashCode;

      expect(anchor.hashCode, equals(hashCode));
    });
  });
}
