import 'package:flutter/material.dart';
import 'package:ytp_new/extensions/text_style_with_opacity.dart';
import 'package:ytp_new/model/video/video.dart';
import 'package:ytp_new/view/thumbnail.dart';

class VideoItem extends StatelessWidget {
  final Video video;
  final void Function()? onTap;
  const VideoItem({super.key, required this.video, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            children: [
              Thumbnail(
                thumbnail: video.thumbnail,
                height: 80,
                width: 80,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      video.author,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .withOpacity(.5),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
