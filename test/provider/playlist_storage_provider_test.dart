import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:ytp_new/persistence/persistence.dart' hide PlaylistStorage;
import 'package:ytp_new/provider/playlist_storage_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  await Persistence.init();
  group('PlaylistStorageProvider', () {
    setUp(() => PlaylistStorageProvider().replace([]));

    test('Adding a playlist should increase the number of playlists', () {
      final playlist = Playlist(
        id: "id",
        title: "title",
        author: "author",
        thumbnail: "thumbnail",
        description: "description",
        videos: [],
      );
      PlaylistStorageProvider().add(playlist);
      expect(PlaylistStorageProvider().playlists.length, 1);
    });

    test('Removing a playlist should decrease the number of playlists', () {
      final playlist = Playlist(
        id: "id",
        title: "title",
        author: "author",
        thumbnail: "thumbnail",
        description: "description",
        videos: [],
      );
      PlaylistStorageProvider().add(playlist);
      final removed = PlaylistStorageProvider().remove(playlist);
      expect(removed, isTrue);
      expect(PlaylistStorageProvider().playlists.length, 0);
    });

    test('Replacing playlists should update the storage with new playlists',
        () {
      final playlists = [
        Playlist(
            id: "1",
            title: "title",
            author: "author",
            thumbnail: "thumbnail",
            description: "description",
            videos: []),
        Playlist(
            id: "2",
            title: "title",
            author: "author",
            thumbnail: "thumbnail",
            description: "description",
            videos: []),
        Playlist(
            id: "3",
            title: "title",
            author: "author",
            thumbnail: "thumbnail",
            description: "description",
            videos: []),
      ];
      PlaylistStorageProvider().replace(playlists);
      expect(PlaylistStorageProvider().playlists, playlists);
    });

    test("fromId should return the Playlist with the id", () {
      final playlist = Playlist(
        id: "id",
        title: "title",
        author: "author",
        thumbnail: "thumbnail",
        description: "description",
        videos: [],
      );

      expect(PlaylistStorageProvider().fromId("id"), null);

      PlaylistStorageProvider().add(playlist);
      expect(PlaylistStorageProvider().fromId("id"), playlist);
    });
  });
}
