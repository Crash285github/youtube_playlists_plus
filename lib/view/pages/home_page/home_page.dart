import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/model/playlist_storage.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/provider/settings_provider.dart';
import 'package:ytp_new/service/app_navigator.dart';
import 'package:ytp_new/view/pages/home_page/drawer/drawer.dart';
import 'package:ytp_new/view/pages/home_page/playlist_item.dart';
import 'package:ytp_new/view/pages/search_page/search_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final playlists =
        Provider.of<PlaylistStorageProvider>(context).playlists.toList();

    final canReorder = Provider.of<SettingsProvider>(context).canReorder;

    return Scaffold(
      drawer: const HomePageDrawer(),
      body: CustomScrollView(slivers: [
        const SliverAppBar(
          title: Text("Playlists"),
          centerTitle: true,
          floating: true,
          snap: true,
        ),
        _Playlists(playlists: playlists),
        const SliverToBoxAdapter(child: SizedBox(height: 80))
      ]),
      floatingActionButton: FloatingActionButton.extended(
        label: AnimatedSize(
          alignment: Alignment.centerRight,
          duration: const Duration(milliseconds: 200),
          curve: Curves.decelerate,
          child: canReorder ? const Text("Finish") : const SizedBox.shrink(),
        ),
        extendedIconLabelSpacing: canReorder ? 8 : 0,
        extendedPadding: const EdgeInsets.all(16),
        onPressed: canReorder
            ? () => SettingsProvider().canReorder = false
            : () => AppNavigator.tryPushLeft(const SearchPage()),
        icon: Icon(canReorder ? Icons.done : Icons.search),
      ),
    );
  }
}

class _Playlists extends StatefulWidget {
  const _Playlists({required this.playlists});

  final List<Playlist> playlists;

  @override
  State<_Playlists> createState() => _PlaylistsState();
}

class _PlaylistsState extends State<_Playlists> {
  @override
  Widget build(BuildContext context) {
    return SliverReorderableList(
      itemCount: widget.playlists.length,
      itemBuilder: (context, index) => ReorderableDragStartListener(
        index: index,
        enabled: SettingsProvider().canReorder,
        key: ValueKey(widget.playlists[index]),
        child: PlaylistItem(
          playlist: widget.playlists[index],
        ),
      ),
      onReorder: (oldIndex, newIndex) {
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }

        setState(() {
          final playlist = widget.playlists.removeAt(oldIndex);
          widget.playlists.insert(newIndex, playlist);
        });

        PlaylistStorage.replace(widget.playlists);
      },
    );
  }
}
