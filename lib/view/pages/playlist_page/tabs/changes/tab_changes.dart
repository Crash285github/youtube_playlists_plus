import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) => changes.isEmpty
      ? const Center(child: Text("No changes."))
      : FadingListView(
          itemBuilder: (context, index) => ChangeItem(
            change: changes[index],
            onTap: () {
              PlaylistStorageProvider().update(() {
                if (changes[index].type == VideoChangeType.addition) {
                  PlaylistStorageProvider().fromId(playlistId)!.videos.add(
                        changes[index],
                      );
                } else {
                  PlaylistStorageProvider().fromId(playlistId)!.videos.remove(
                        changes[index],
                      );
                }
              });
            },
          ),
          itemCount: changes.length,
        );
}
