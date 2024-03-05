import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/view/pages/home_page/playlist_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final playlists = Provider.of<PlaylistStorageProvider>(context).playlists;

    return Scaffold(
      body: CustomScrollView(slivers: [
        const SliverAppBar(),
        SliverList.list(
            children: [...playlists.map((e) => PlaylistItem(playlist: e))]),
      ]),
    );
  }
}
