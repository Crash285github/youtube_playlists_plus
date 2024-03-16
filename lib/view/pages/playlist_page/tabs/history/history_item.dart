import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/extensions/datetime_timeago.dart';
import 'package:ytp_new/extensions/media_context.dart';
import 'package:ytp_new/extensions/string_hide_topic.dart';
import 'package:ytp_new/extensions/text_style_with_opacity.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/model/video/video_history.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/provider/settings_provider.dart';
import 'package:ytp_new/service/context_menu_service.dart';

class HistoryItem extends StatelessWidget {
  final String playlistId;
  final VideoHistory history;
  final void Function()? onTap;
  final bool isFirst, isLast;
  const HistoryItem({
    super.key,
    required this.history,
    this.onTap,
    required this.playlistId,
    this.isFirst = false,
    this.isLast = false,
  });

  Playlist get playlist => PlaylistStorageProvider().fromId(playlistId)!;

  BorderRadiusGeometry get borderRadius => BorderRadius.only(
        bottomLeft: Radius.circular(isLast ? 16.0 : 4.0),
        bottomRight: Radius.zero,
        topLeft: Radius.circular(isFirst ? 16.0 : 4.0),
        topRight: Radius.zero,
      );

  String get author => SettingsProvider().hideTopic
      ? history.author.hideTopic()
      : history.author;

  @override
  Widget build(BuildContext context) {
    Provider.of<SettingsProvider>(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      margin: const EdgeInsets.only(
        right: 0.0,
        left: 8.0,
        top: 2.0,
        bottom: 2.0,
      ),
      child: InkWell(
        onTapUp: (details) => ContextMenuService.show(
          context: context,
          offset: details.globalPosition,
          items: [
            history.contextOpen,
            history.contextCopyTitle,
            history.contextCopyLink,
            history.contextCopyId,
            PopupMenuItem(
              onTap: () => PlaylistStorageProvider().update(
                () => playlist.removeHistory(history),
                save: true,
              ),
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
                        "$author • ${history.created.timeago()}",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
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
      ),
    );
  }
}
