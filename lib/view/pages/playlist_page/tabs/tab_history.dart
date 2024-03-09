import 'package:flutter/material.dart';
import 'package:ytp_new/model/video/video_history.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/view/fading_listview.dart';
import 'package:ytp_new/view/pages/playlist_page/video_item.dart';

class PlaylistPageTabHistory extends StatelessWidget {
  final String playlistId;
  final List<VideoHistory> history;
  const PlaylistPageTabHistory(
      {super.key, required this.history, required this.playlistId});

  @override
  Widget build(BuildContext context) => history.isEmpty
      ? const Center(child: Text("No history."))
      : FadingListView(
          gradientHeight: 50,
          itemBuilder: (context, index) => VideoItem(
            video: history[index],
            onTap: () {
              PlaylistStorageProvider().update(() {
                PlaylistStorageProvider()
                    .fromId(playlistId)!
                    .removeHistory(history[index]);
              });
            },
          ),
          itemCount: history.length,
        );
}
