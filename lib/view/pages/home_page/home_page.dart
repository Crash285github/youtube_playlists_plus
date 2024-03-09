import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/service/app_navigator.dart';
import 'package:ytp_new/view/pages/home_page/drawer/drawer.dart';
import 'package:ytp_new/view/pages/home_page/playlist_item.dart';
import 'package:ytp_new/view/pages/search_page/search_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final playlists = Provider.of<PlaylistStorageProvider>(context).playlists;

    return Scaffold(
      drawer: const HomePageDrawer(),
      body: CustomScrollView(slivers: [
        const SliverAppBar(
          title: Text("Playlists"),
          centerTitle: true,
          floating: true,
          snap: true,
        ),
        SliverList.list(
          children: [
            ...playlists.map((e) => PlaylistItem(playlist: e)),
          ],
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 80))
      ]),
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
          child: const Icon(Icons.search),
          onPressed: () => AppNavigator.tryPushLeft(const SearchPage()),
        );
      }),
    );
  }
}
