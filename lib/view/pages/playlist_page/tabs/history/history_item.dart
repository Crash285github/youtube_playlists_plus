import 'package:flutter/material.dart';
import 'package:ytp_new/extensions/datetime_timeago.dart';
import 'package:ytp_new/extensions/string_to_clipboard.dart';
import 'package:ytp_new/extensions/text_style_with_opacity.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/model/video/video_history.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/service/context_menu_service.dart';
import 'package:ytp_new/view/widget/media_item_template.dart';

class HistoryItem extends StatelessWidget {
  final String playlistId;
  final VideoHistory history;
  final void Function()? onTap;
  const HistoryItem({
    super.key,
    required this.history,
    this.onTap,
    required this.playlistId,
  });

  Playlist get playlist => PlaylistStorageProvider().fromId(playlistId)!;
  void Function(void Function()) get update => PlaylistStorageProvider().update;

  @override
  Widget build(BuildContext context) => MediaItemTemplate(
        onSecondary: (details) => ContextMenuService.show(
          context: context,
          offset: details,
          items: [
            PopupMenuItem(
              onTap: () => history.open(),
              child: const Text("Open"),
            ),
            PopupMenuItem(
              onTap: () => history.title.copyToClipboard(),
              child: const Text("Copy title"),
            ),
            PopupMenuItem(
              onTap: () => history.id.copyToClipboard(),
              child: const Text("Copy id"),
            ),
            PopupMenuItem(
              onTap: () => history.link.copyToClipboard(),
              child: const Text("Copy link"),
            ),
            PopupMenuItem(
              onTap: () => update(() => playlist.removeHistory(history)),
              child: const Text("Remove"),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        history.title,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        "${history.author} • ${history.created.timeago()}",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .withOpacity(.5),
                      ),
                    ],
                  ),
                ),
              ),
              Icon(
                history.type.icon,
                color: history.type.color,
              )
            ],
          ),
        ),
      );
}
