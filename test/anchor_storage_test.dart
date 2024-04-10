import 'package:test/test.dart';
import 'package:ytp_new/model/video/video.dart';
import 'package:ytp_new/persistence/persistence.dart';

void main() {
  group('AnchorStorage', () {

    setUp(() => AnchorStorage.replace([]));
    test('change() should replace or add an anchor to the list', () {
      const anchor1 = Anchor(
        playlistId: "playlistId",
        videoId: "videoId",
        position: AnchorPosition.start,
        offset: 0,
      );
      const anchor2 = Anchor(
        playlistId: "playlistId",
        videoId: "videoId",
        position: AnchorPosition.end,
        offset: 0,
      );

      AnchorStorage.change(anchor1);
      expect(AnchorStorage.anchors, contains(anchor1));
      expect(AnchorStorage.anchors.length, 1);

      AnchorStorage.change(anchor2);
      expect(AnchorStorage.anchors, contains(anchor2));
      expect(AnchorStorage.anchors.length, 1);
    });

    test('remove() should remove an anchor from the list', () {
      const anchor = Anchor(
        playlistId: "playlistId",
        videoId: "videoId",
        position: AnchorPosition.start,
        offset: 0,
      );
      AnchorStorage.change(anchor);

      final removed = AnchorStorage.remove(anchor);
      expect(removed, isTrue);
      expect(AnchorStorage.anchors, isNot(contains(anchor)));
    });

    test('replace() should replace all anchors with the given list', () {
      final anchors = [
        const Anchor(
          playlistId: "playlistId",
          videoId: "videoId",
          position: AnchorPosition.start,
          offset: 0,
        ),
        const Anchor(
          playlistId: "playlistId",
          videoId: "videoId",
          position: AnchorPosition.end,
          offset: 0,
        ),
      ];

      AnchorStorage.replace(anchors);
      expect(AnchorStorage.anchors, equals(anchors));
    });
  });
}
