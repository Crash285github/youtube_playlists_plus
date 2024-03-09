import 'package:flutter/material.dart';
import 'package:ytp_new/model/video/history_type.dart';
import 'package:ytp_new/model/video/video.dart';
import 'package:ytp_new/model/video/video_history.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/view/fading_listview.dart';
import 'package:ytp_new/view/pages/playlist_page/video_item.dart';

class PlaylistPageTabVideos extends StatelessWidget {
  final String playlistId;
  final List<Video> videos;
  const PlaylistPageTabVideos({
    super.key,
    required this.videos,
    required this.playlistId,
  });

  @override
  Widget build(BuildContext context) {
    return FadingListView(
      gradientHeight: 50,
      bottom: false,
      padding: const EdgeInsets.symmetric(vertical: 50),
      itemCount: videos.length,
      itemBuilder: (context, index) => VideoItem(
        video: videos[index],
        onTap: () {
          PlaylistStorageProvider().update(() {
            PlaylistStorageProvider().fromId(playlistId)!.pendingHistory.add(
                  VideoHistory.fromVideo(
                    videos[index],
                    VideoHistoryType.addition,
                  ),
                );
          });
        },
      ),
    );
  }
}
