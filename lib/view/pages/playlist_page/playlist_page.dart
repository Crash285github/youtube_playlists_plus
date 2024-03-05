import 'package:flutter/material.dart';
import 'package:ytp_new/model/playlist.dart';
import 'package:ytp_new/view/pages/playlist_page/video_item.dart';

class PlaylistPage extends StatelessWidget {
  final Playlist playlist;
  const PlaylistPage({
    super.key,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(playlist.title)),
      body: ListView(children: [
        ...playlist.videos.map((e) => VideoItem(
              video: e,
            ))
      ]),
    );
  }
}
