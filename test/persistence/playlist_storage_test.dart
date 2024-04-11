import 'package:test/test.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/persistence/persistence.dart';

void main() {
  group('PlaylistStorage', () {
    setUp(() => PlaylistStorage.replace([]));

    test('Adding a playlist should increase the number of playlists', () {
      final playlist = Playlist(
        id: "id",
        title: "title",
        author: "author",
        thumbnail: "thumbnail",
        description: "description",
        videos: [],
      );
      PlaylistStorage.add(playlist);
      expect(PlaylistStorage.playlists.length, 1);
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
      PlaylistStorage.add(playlist);
      final removed = PlaylistStorage.remove(playlist);
      expect(removed, isTrue);
      expect(PlaylistStorage.playlists.length, 0);
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
      PlaylistStorage.replace(playlists);
      expect(PlaylistStorage.playlists, playlists);
    });
  });
}
