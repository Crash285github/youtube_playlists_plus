import 'package:flutter/material.dart';
import 'package:ytp_new/model/video/video_change.dart';
import 'package:ytp_new/view/thumbnail.dart';

class ChangeItem extends StatelessWidget {
  final VideoChange change;
  final void Function()? onTap;
  const ChangeItem({super.key, required this.change, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onTap == null ? 0.5 : 1,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(children: [
              Thumbnail(
                thumbnail: change.thumbnail,
                height: 80,
                width: 80,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
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
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
