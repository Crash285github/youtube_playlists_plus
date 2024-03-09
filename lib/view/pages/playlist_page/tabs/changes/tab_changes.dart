import 'package:flutter/material.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/model/video/change_type.dart';
import 'package:ytp_new/model/video/video_change.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/view/fading_listview.dart';
import 'package:ytp_new/view/pages/playlist_page/tabs/changes/change_item.dart';

class PlaylistPageTabChanges extends StatelessWidget {
  final String playlistId;
  final List<VideoChange> changes;
  const PlaylistPageTabChanges({
    super.key,
    required this.playlistId,
    required this.changes,
  });

  Playlist get playlist => PlaylistStorageProvider().fromId(playlistId)!;

  Function()? _onTap(VideoChange change) {
    if (change.isAddition && playlist.videos.contains(change)) {
      return null;
    }

    if (change.isRemoval && !playlist.videos.contains(change)) {
      return null;
    }

    return () => PlaylistStorageProvider().update(() {
          if (change.type == VideoChangeType.addition) {
            PlaylistStorageProvider().fromId(playlistId)!.videos.add(
                  change,
                );
          } else {
            PlaylistStorageProvider().fromId(playlistId)!.videos.remove(
                  change,
                );
          }
        });
  }

  @override
  Widget build(BuildContext context) => changes.isEmpty
      ? const Center(child: Text("No changes."))
      : FadingListView(
          gradientHeight: 50,
          bottom: false,
          padding: const EdgeInsets.only(bottom: 80),
          itemBuilder: (context, index) => ChangeItem(
            change: changes[index],
            onTap: _onTap(changes[index]),
          ),
          itemCount: changes.length,
        );
}
