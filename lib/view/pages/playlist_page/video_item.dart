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
            Container(
                height: 80,
                width: 80,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(12)),
                clipBehavior: Clip.antiAlias,
                margin: const EdgeInsets.all(5),
                child: Image.network(
                  video.thumbnail,
                  fit: BoxFit.cover,
                )),
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
