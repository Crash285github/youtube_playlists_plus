import 'package:flutter/material.dart';
import 'package:ytp_new/model/video.dart';
import 'package:ytp_new/view/thumbnail.dart';

class VideoItem extends StatelessWidget {
  final Video video;
  const VideoItem({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Thumbnail(
              thumbnail: video.thumbnail,
              height: 80,
              width: 80,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  video.author,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
