import 'package:flutter/material.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/model/video/video.dart';
import 'package:ytp_new/model/video/video_change.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/view/pages/playlist_page/tabs/changes/anchor_item.dart';
import 'package:ytp_new/view/widget/fading_listview.dart';
import 'package:ytp_new/view/pages/playlist_page/tabs/changes/change_item.dart';

class PlaylistPageTabChanges extends StatefulWidget {
  final String playlistId;
  const PlaylistPageTabChanges({
    super.key,
    required this.playlistId,
  });

  @override
  State<PlaylistPageTabChanges> createState() => _PlaylistPageTabChangesState();
}

class _PlaylistPageTabChangesState extends State<PlaylistPageTabChanges>
    with AutomaticKeepAliveClientMixin {
  Playlist get playlist => PlaylistStorageProvider().fromId(widget.playlistId)!;

  List<VideoChange> get changes => playlist.changes;

  List<Video> get anchorIssues => playlist.anchoredVideos
      .where((final video) => !video.anchorInPlace)
      .toList();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return changes.isEmpty
        ? anchorIssues.isEmpty
            ? const Center(child: Text("No changes."))
            : FadingListView(
                gradientHeight: 50,
                bottom: false,
                padding: const EdgeInsets.only(bottom: 80),
                itemBuilder: (context, index) => AnchorItem(
                  playlistId: playlist.id,
                  video: anchorIssues[index],
                  isFirst: index == 0,
                  isLast: index == anchorIssues.length - 1,
                ),
                itemCount: anchorIssues.length,
              )
        : FadingListView(
            gradientHeight: 50,
            bottom: false,
            padding: const EdgeInsets.only(bottom: 80),
            itemBuilder: (context, index) => ChangeItem(
              change: changes[index],
              playlistId: playlist.id,
              isFirst: index == 0,
              isLast: index == changes.length - 1,
            ),
            itemCount: changes.length,
          );
  }

  @override
  bool get wantKeepAlive => mounted;
}
