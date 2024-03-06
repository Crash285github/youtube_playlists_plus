import 'package:flutter/material.dart';
import 'package:ytp_new/model/playlist.dart';
import 'package:ytp_new/view/pages/playlist_page/tabs/tab_videos.dart';

class PlaylistPage extends StatelessWidget {
  final Playlist playlist;
  const PlaylistPage({
    super.key,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(playlist.title),
          bottom: const TabBar(
            tabs: [
              _TabItem(icon: Icon(Icons.change_circle), text: "Changes"),
              _TabItem(icon: Icon(Icons.list), text: "Videos"),
              _TabItem(icon: Icon(Icons.history), text: "History")
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const Text("1"),
            PlaylistPageTabVideos(videos: playlist.videos),
            const Text("3"),
          ],
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final Icon icon;
  final String text;
  const _TabItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) => Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 10),
            Text(text),
          ],
        ),
      );
}
