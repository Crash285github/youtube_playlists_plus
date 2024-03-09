import 'package:flutter/material.dart';
import 'package:ytp_new/model/video/video_change.dart';
import 'package:ytp_new/view/thumbnail.dart';

class ChangeItem extends StatelessWidget {
  final VideoChange change;
  final void Function()? onTap;
  const ChangeItem({super.key, required this.change, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Row(children: [
          Thumbnail(
            thumbnail: change.thumbnail,
            height: 80,
            width: 80,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  change.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  change.author,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
          change.type.icon,
        ]),
      ),
    );
  }
}