import 'package:flutter/material.dart';
import 'package:ytp_new/model/video/video.dart';
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
      ),
    );
  }
}
