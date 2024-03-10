import 'package:flutter/material.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/model/playlist_storage.dart';
import 'package:ytp_new/provider/settings_provider.dart';
import 'package:ytp_new/view/pages/home_page/playlist_item.dart';

class PlaylistListView extends StatefulWidget {
  const PlaylistListView({super.key, required this.playlists});

  final List<Playlist> playlists;

  @override
  State<PlaylistListView> createState() => _PlaylistListViewState();
}

class _PlaylistListViewState extends State<PlaylistListView> {
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
          isFirst: index == 0,
          isLast: index == widget.playlists.length - 1,
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
