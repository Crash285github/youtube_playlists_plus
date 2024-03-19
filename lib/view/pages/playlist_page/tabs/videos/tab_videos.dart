import 'package:flutter/material.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/model/video/video.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/view/widget/fading_listview.dart';
import 'package:ytp_new/view/pages/playlist_page/tabs/videos/video_item.dart';

import 'planned_sheet/planned_sheet.dart';

class PlaylistPageTabVideos extends StatefulWidget {
  final String playlistId;
  const PlaylistPageTabVideos({
    super.key,
    required this.playlistId,
  });

  @override
  State<PlaylistPageTabVideos> createState() => _PlaylistPageTabVideosState();
}

class _PlaylistPageTabVideosState extends State<PlaylistPageTabVideos>
    with AutomaticKeepAliveClientMixin {
  Playlist get playlist => PlaylistStorageProvider().fromId(widget.playlistId)!;

  List<Video> get videos => playlist.videos;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        FadingListView(
          gradientHeight: 50,
          bottom: false,
          itemCount: videos.length,
          padding: const EdgeInsets.only(bottom: 60),
          itemBuilder: (context, index) => VideoItem(
            video: videos.elementAt(index),
            isFirst: index == 0,
            isLast: index == videos.length - 1,
          ),
        ),
        PlannedSheet(
          playlistId: playlist.id,
          planned: playlist.planned.reversed,
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => mounted;
}
