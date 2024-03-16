import 'package:flutter/material.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/model/video/video_change.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/view/widget/fading_listview.dart';
import 'package:ytp_new/view/pages/playlist_page/tabs/changes/change_item.dart';

class PlaylistPageTabChanges extends StatefulWidget {
  final String playlistId;
  final List<VideoChange> changes;
  const PlaylistPageTabChanges({
    super.key,
    required this.playlistId,
    required this.changes,
  });

  @override
  State<PlaylistPageTabChanges> createState() => _PlaylistPageTabChangesState();
}

class _PlaylistPageTabChangesState extends State<PlaylistPageTabChanges>
    with AutomaticKeepAliveClientMixin {
  Playlist get playlist => PlaylistStorageProvider().fromId(widget.playlistId)!;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.changes.isEmpty
        ? const Center(child: Text("No changes."))
        : FadingListView(
            gradientHeight: 50,
            bottom: false,
            padding: const EdgeInsets.only(bottom: 80),
            itemBuilder: (context, index) => ChangeItem(
              change: widget.changes[index],
              playlistId: playlist.id,
              isFirst: index == 0,
              isLast: index == widget.changes.length - 1,
            ),
            itemCount: widget.changes.length,
          );
  }

  @override
  bool get wantKeepAlive => mounted;
}
