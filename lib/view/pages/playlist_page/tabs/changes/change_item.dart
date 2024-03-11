import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/extensions/media_context.dart';
import 'package:ytp_new/extensions/string_hide_topic.dart';
import 'package:ytp_new/extensions/text_style_with_opacity.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/model/video/change_type.dart';
import 'package:ytp_new/model/video/video_change.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/provider/settings_provider.dart';
import 'package:ytp_new/service/context_menu_service.dart';
import 'package:ytp_new/view/widget/media_item_template.dart';
import 'package:ytp_new/view/widget/thumbnail.dart';

class ChangeItem extends StatelessWidget {
  final String playlistId;
  final VideoChange change;
  final bool isFirst, isLast;
  const ChangeItem({
    super.key,
    required this.playlistId,
    required this.change,
    this.isFirst = false,
    this.isLast = false,
  });

  BorderRadiusGeometry get borderRadius => BorderRadius.only(
        bottomLeft: Radius.circular(isLast ? 16.0 : 4.0),
        bottomRight: Radius.circular(isLast ? 16.0 : 4.0),
        topLeft: Radius.circular(isFirst ? 16.0 : 4.0),
        topRight: Radius.circular(isFirst ? 16.0 : 4.0),
      );

  BorderRadius get thumbnailBorderRadius => BorderRadius.only(
        bottomLeft: Radius.circular(isLast ? 14.0 : 4.0),
        bottomRight: const Radius.circular(4.0),
        topLeft: Radius.circular(isFirst ? 14.0 : 4.0),
        topRight: const Radius.circular(4.0),
      );

  String get author =>
      SettingsProvider().hideTopic ? change.author.hideTopic() : change.author;

  Playlist get playlist => PlaylistStorageProvider().fromId(playlistId)!;

  bool get enabled =>
      (change.isAddition && !playlist.videos.contains(change)) ||
      (change.isRemoval && playlist.videos.contains(change));

  void _update() => PlaylistStorageProvider().update(
        () {
          if (change.type == VideoChangeType.addition) {
            playlist.videos.add(change);
          } else {
            playlist.videos.remove(change);
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    Provider.of<SettingsProvider>(context);
    return Opacity(
      opacity: enabled ? 1 : 0.7,
      child: MediaItemTemplate(
        borderRadius: borderRadius,
        onTap: (offset) => ContextMenuService.show(
          context: context,
          offset: offset,
          items: [
            change.contextOpen,
            PopupMenuItem(
              enabled: enabled,
              onTap: _update,
              child: Text(change.isAddition ? "Add" : "Remove"),
            ),
            change.contextCopyTitle,
            change.contextCopyId,
            change.contextCopyLink,
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(children: [
            Thumbnail(
              thumbnail: change.thumbnail,
              borderRadius: thumbnailBorderRadius,
              height: 80,
              width: 80,
            ),
            Expanded(
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
                              change.title,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              author,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .withOpacity(.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: enabled ? _update : null,
                      icon: Icon(change.type.icon),
                      color: change.type.color,
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
