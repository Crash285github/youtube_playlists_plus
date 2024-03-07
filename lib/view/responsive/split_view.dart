import 'package:flutter/material.dart';
import 'package:ytp_new/model/playlist_storage.dart';
import 'package:ytp_new/view/pages/home_page/home_page.dart';
import 'package:ytp_new/view/pages/playlist_page/playlist_page.dart';

class SplitView extends StatelessWidget {
  const SplitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        if (PlaylistStorage.playlists.isNotEmpty)
          Expanded(
              child: PlaylistPage(playlist: PlaylistStorage.playlists.first)),
        const Expanded(child: HomePage())
      ],
    );
  }
}
