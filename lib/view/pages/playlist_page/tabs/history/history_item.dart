import 'package:flutter/material.dart';
import 'package:ytp_new/model/video/video_history.dart';

class HistoryItem extends StatelessWidget {
  final VideoHistory history;
  final void Function()? onTap;
  const HistoryItem({super.key, required this.history, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      history.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      history.author,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              history.type.icon,
            ],
          ),
        ),
      ),
    );
  }
}
