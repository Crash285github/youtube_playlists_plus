import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ytp_new/extensions/extensions.dart';
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
        videos.isEmpty
            ? Center(
                child: Text(
                  "No videos.",
                  style:
                      Theme.of(context).textTheme.labelLarge!.withOpacity(.5),
                ),
              )
            : FadingListView(
                gradientHeight: 70,
                bottom: false,
                itemCount: playlist.length,
                padding: const EdgeInsets.only(bottom: 60, top: 20),
                itemBuilder: (context, index) => VideoItem(
                  video: playlist[index],
                  isFirst: index == 0,
                  isLast: index == playlist.length - 1,
                ),
              ),
        if (Platform.isAndroid)
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
