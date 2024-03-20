import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
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
  List<Playlist> get playlists => [...PlaylistStorage.playlists];

  @override
  Widget build(BuildContext context) {
    context.watch<PlaylistStorageProvider>();
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
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }

        setState(() {
          final playlist = playlists.removeAt(oldIndex);
          playlists.insert(newIndex, playlist);
        });

        PlaylistStorage.replace(playlists);
      },
    );
  }
}
