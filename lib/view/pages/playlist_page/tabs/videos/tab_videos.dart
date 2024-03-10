import 'package:flutter/material.dart';
import 'package:ytp_new/model/video/video.dart';
import 'package:ytp_new/view/widget/fading_listview.dart';
import 'package:ytp_new/view/pages/playlist_page/tabs/videos/video_item.dart';

class PlaylistPageTabVideos extends StatefulWidget {
  final String playlistId;
  final List<Video> videos;
  const PlaylistPageTabVideos({
    super.key,
    required this.videos,
    required this.playlistId,
  });

  @override
  State<PlaylistPageTabVideos> createState() => _PlaylistPageTabVideosState();
}

class _PlaylistPageTabVideosState extends State<PlaylistPageTabVideos>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FadingListView(
      gradientHeight: 50,
      bottom: false,
      itemCount: widget.videos.length,
      padding: const EdgeInsets.only(bottom: 80),
      itemBuilder: (context, index) => VideoItem(
        video: widget.videos[index],
        isFirst: index == 0,
        isLast: index == widget.videos.length - 1,
      ),
    );
  }

  @override
  bool get wantKeepAlive => mounted;
}
