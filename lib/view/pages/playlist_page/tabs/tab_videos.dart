import 'package:flutter/material.dart';
import 'package:ytp_new/model/video.dart';
import 'package:ytp_new/view/fading_listview.dart';
import 'package:ytp_new/view/pages/playlist_page/video_item.dart';

class PlaylistPageTabVideos extends StatelessWidget {
  final List<Video> videos;
  const PlaylistPageTabVideos({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    return FadingListView(
      gradientHeight: 50,
      bottom: false,
      padding: const EdgeInsets.symmetric(vertical: 50),
      itemCount: videos.length,
      itemBuilder: (context, index) => VideoItem(video: videos[index]),
    );
  }
}
