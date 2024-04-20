import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:ytp_new/persistence/persistence.dart';
import 'package:ytp_new/provider/fetching_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  await Persistence.init();

  group("FetchingProvider", () {
    setUp(() {
      while (FetchingProvider().downloading) {
        FetchingProvider().decrementDownload();
      }

      FetchingProvider().refreshing.clear();
    });
    test("incrementDownload() increments download", () {
      final currentDownload = FetchingProvider().downloadCount;

      FetchingProvider().incrementDownload();
      expect(FetchingProvider().downloadCount, currentDownload + 1);
    });

    test("decrementDownload() decrements download until 0", () {
      for (int i = 0; i < 10; i++) {
        FetchingProvider().incrementDownload();
      }

      expect(FetchingProvider().downloadCount, 10);

      for (int i = 0; i < 10; i++) {
        FetchingProvider().decrementDownload();
      }

      expect(FetchingProvider().downloadCount, 0);

      FetchingProvider().decrementDownload();

      expect(FetchingProvider().downloadCount, 0);
    });

    test("add() adds a playlistId to the refreshingList only once", () {
      expect(FetchingProvider().refreshingList, isEmpty);
      FetchingProvider().add("playlistId");
      FetchingProvider().add("playlistId");

      expect(FetchingProvider().refreshingList, contains("playlistId"));
      expect(FetchingProvider().refreshingList.length, 1);
    });

    test("remove() removes a playlistId from the refreshingList", () {
      expect(FetchingProvider().refreshingList, isEmpty);

      FetchingProvider().add("playlistId");
      FetchingProvider().add("playlistId");

      FetchingProvider().remove("playlistId");
      expect(FetchingProvider().refreshingList, isEmpty);
    });

    test("isRefreshingPlaylist() returns valid values", () {
      expect(FetchingProvider().refreshingList, isEmpty);

      expect(FetchingProvider().isRefreshingPlaylist("playlistId"), false);

      FetchingProvider().add("playlistId");

      expect(FetchingProvider().isRefreshingPlaylist("playlistId"), true);
    });
  });
}
