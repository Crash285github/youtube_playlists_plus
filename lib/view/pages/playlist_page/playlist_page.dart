import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
          backgroundColor: Colors.transparent,
          bottom: const TabBar(
            dividerHeight: 0,
            tabs: [
              _TabItem(icon: Icon(Icons.change_circle), text: "Changes"),
              _TabItem(icon: Icon(Icons.list), text: "Videos"),
              _TabItem(icon: Icon(Icons.history), text: "History")
            ],
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.transparent],
                    ).createShader(
                        Rect.fromLTRB(0, 0, rect.width, rect.height));
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image.network(
                    playlist.thumbnail,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: SafeArea(
                child: TabBarView(
                  children: [
                    const Text("1"),
                    PlaylistPageTabVideos(videos: playlist.videos),
                    const Text("3"),
                  ],
                ),
              ),
            ),
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
