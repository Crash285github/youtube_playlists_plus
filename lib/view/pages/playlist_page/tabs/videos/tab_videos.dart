import 'package:flutter/material.dart';
import 'package:ytp_new/model/video/change_type.dart';
import 'package:ytp_new/model/video/video.dart';
import 'package:ytp_new/model/video/video_history.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/view/fading_listview.dart';
import 'package:ytp_new/view/pages/playlist_page/tabs/videos/video_item.dart';

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
      itemCount: videos.length,
      padding: const EdgeInsets.only(bottom: 80),
      itemBuilder: (context, index) => VideoItem(
        video: videos[index],
        onTap: () {
          PlaylistStorageProvider().update(() {
            PlaylistStorageProvider().fromId(playlistId)!.pendingHistory.add(
                  VideoHistory.fromVideo(
                    videos[index],
                    VideoChangeType.addition,
                  ),
                );
          });
        },
      ),
    );
  }
}
