import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/model/playlist_storage.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/provider/settings_provider.dart';
import 'package:ytp_new/view/pages/home_page/playlist_item.dart';

class PlaylistListView extends StatefulWidget {
  const PlaylistListView({super.key});

  @override
  State<PlaylistListView> createState() => _PlaylistListViewState();
}

class _PlaylistListViewState extends State<PlaylistListView> {
  @override
  Widget build(BuildContext context) {
    final playlists = context.watch<PlaylistStorageProvider>().playlists;
    context.select<SettingsProvider, bool>(
      (final settings) => settings.canReorder,
    );

    return SliverReorderableList(
      itemCount: playlists.length,
      itemBuilder: (context, index) => ReorderableDragStartListener(
        index: index,
        enabled: SettingsProvider().canReorder,
        key: ValueKey(playlists[index]),
        child: PlaylistItem(
          playlist: playlists[index],
          isFirst: index == 0,
          isLast: index == playlists.length - 1,
        ),
      ),
      onReorder: (oldIndex, newIndex) {
        final copy = playlists.toList();
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }

        setState(() {
          final playlist = copy.removeAt(oldIndex);
          copy.insert(newIndex, playlist);
        });

        PlaylistStorage.replace(copy);
      },
    );
  }
}
