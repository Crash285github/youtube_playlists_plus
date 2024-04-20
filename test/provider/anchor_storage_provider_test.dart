import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/persistence/persistence.dart';
import 'package:ytp_new/provider/anchor_storage_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  await Persistence.init();

  group('AnchorStorageProvider', () {
    setUp(() => AnchorStorageProvider().replace([]));
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

      AnchorStorageProvider().change(anchor1);
      expect(AnchorStorageProvider().anchors, contains(anchor1));
      expect(AnchorStorageProvider().anchors.length, 1);

      AnchorStorageProvider().change(anchor2);
      expect(AnchorStorageProvider().anchors, contains(anchor2));
      expect(AnchorStorageProvider().anchors.length, 1);
    });

    test('remove() should remove an anchor from the list', () {
      const anchor = Anchor(
        playlistId: "playlistId",
        videoId: "videoId",
        position: AnchorPosition.start,
        offset: 0,
      );
      AnchorStorageProvider().change(anchor);

      final removed = AnchorStorageProvider().remove(anchor);
      expect(removed, isTrue);
      expect(AnchorStorageProvider().anchors, isNot(contains(anchor)));
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

      AnchorStorageProvider().replace(anchors);
      expect(AnchorStorageProvider().anchors, equals(anchors));
    });

    test('fromVideo() should find the video that has an anchor', () {
      final video = Video(
        id: "videoId",
        title: "title",
        author: "author",
        thumbnail: "thumbnail",
        playlistId: "playlistId",
      );

      const anchor = Anchor(
        playlistId: "playlistId",
        videoId: "videoId",
        position: AnchorPosition.start,
        offset: 0,
      );

      PlaylistStorage.add(
        Playlist(
          id: "playlistId",
          title: "title",
          author: "author",
          thumbnail: "thumbnail",
          description: "description",
          videos: [video],
        ),
      );

      expect(AnchorStorageProvider().fromVideo(video), null);

      AnchorStorage.change(anchor);
      expect(AnchorStorageProvider().fromVideo(video), anchor);
    });
  });
}
