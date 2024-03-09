import 'package:flutter/material.dart';
import 'package:ytp_new/extensions/datetime_timeago.dart';
import 'package:ytp_new/extensions/string_to_clipboard.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/model/video/video_history.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/service/context_menu_service.dart';
import 'package:ytp_new/view/adaptive_ink_well.dart';

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

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: AdaptiveSecondary(
        secondary: (details) =>
            ContextMenuService.show(context: context, offset: details, items: [
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
            onTap: () {
              PlaylistStorageProvider().update(() {
                playlist.removeHistory(history);
              });
            },
            child: const Text("Remove"),
          ),
        ]),
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
                      "${history.author} • ${history.created.timeago()}",
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
