import 'package:flutter/material.dart';
import 'package:ytp_new/model/video.dart';

class VideoItem extends StatelessWidget {
  final Video video;
  const VideoItem({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Image.network(video.thumbnail),
            Text(video.title),
          ],
        ),
      ),
    );
  }
}
