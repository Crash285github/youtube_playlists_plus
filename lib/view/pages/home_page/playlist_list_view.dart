import 'package:flutter/material.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/model/playlist_storage.dart';
import 'package:ytp_new/provider/settings_provider.dart';
import 'package:ytp_new/view/pages/home_page/playlist_item.dart';

class PlaylistListView extends StatefulWidget {
  final List<Playlist> playlists;
  const PlaylistListView({super.key, required this.playlists});

  @override
  State<PlaylistListView> createState() => _PlaylistListViewState();
}

class _PlaylistListViewState extends State<PlaylistListView> {
  late final playlists = widget.playlists.toList();
  @override
  Widget build(BuildContext context) {
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
