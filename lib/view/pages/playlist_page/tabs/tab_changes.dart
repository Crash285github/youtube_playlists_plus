import 'package:flutter/material.dart';
import 'package:ytp_new/model/video/video.dart';
import 'package:ytp_new/view/fading_listview.dart';
import 'package:ytp_new/view/pages/playlist_page/video_item.dart';

class PlaylistPageTabChanges extends StatelessWidget {
  final List<Video> changes;
  const PlaylistPageTabChanges({super.key, required this.changes});

  @override
  Widget build(BuildContext context) => changes.isEmpty
      ? const Center(child: Text("No changes."))
      : FadingListView(
          itemBuilder: (context, index) => VideoItem(video: changes[index]),
          itemCount: changes.length,
        );
}
