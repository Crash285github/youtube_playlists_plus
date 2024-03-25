import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/extensions/media_context.dart';
import 'package:ytp_new/extensions/offset_context_menu.dart';
import 'package:ytp_new/extensions/text_style_with_opacity.dart';
import 'package:ytp_new/model/persistence.dart';
import 'package:ytp_new/model/settings/settings.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/provider/settings_provider.dart';
import 'package:ytp_new/service/popup_service.dart';
import 'package:ytp_new/view/widget/app_navigator.dart';
import 'package:ytp_new/view/pages/playlist_page/playlist_page.dart';
import 'package:ytp_new/view/widget/media_item_template.dart';
import 'package:ytp_new/view/widget/thumbnail.dart';

class PlaylistItem extends StatelessWidget {
  final Playlist playlist;
  final bool isFirst, isLast;
  const PlaylistItem({
    super.key,
    required this.playlist,
    this.isFirst = false,
    this.isLast = false,
  });

  BorderRadiusGeometry get borderRadius => BorderRadius.only(
        bottomLeft: Radius.circular(isLast ? 20.0 : 4.0),
        bottomRight: Radius.circular(isLast ? 20.0 : 4.0),
        topLeft: Radius.circular(isFirst ? 20.0 : 4.0),
        topRight: Radius.circular(isFirst ? 20.0 : 4.0),
      );

  BorderRadius get thumbnailBorderRadius => BorderRadius.only(
        bottomLeft: Radius.circular(isLast ? 18.0 : 4.0),
        bottomRight: const Radius.circular(4.0),
        topLeft: Radius.circular(isFirst ? 18.0 : 4.0),
        topRight: const Radius.circular(4.0),
      );

  String get author => playlist.author.startsWith('by ')
      ? playlist.author.substring(3)
      : playlist.author;

  @override
  Widget build(BuildContext context) {
    final canReorder = context.select<SettingsProvider, bool>(
      (final settings) => settings.canReorder,
    );

    return MediaItem(
      primaryAction: (_) {
        SettingsProvider().canReorder = false;
        AppNavigator.tryPopRight();
        AppNavigator.tryPushRight(PlaylistPage(playlistId: playlist.id));
        Persistence.currentlyShowingPlaylistId = playlist.id;
      },
      secondaryAction: (offset) => offset.showContextMenu(
        context: context,
        items: <PopupMenuEntry>[
          playlist.contextOpen,
          const PopupMenuDivider(height: 0),
          playlist.contextCopyTitle,
          playlist.contextCopyId,
          playlist.contextCopyLink,
          const PopupMenuDivider(height: 0),
          PopupMenuItem(
            onTap: () {
              if (Settings.confirmDeletes) {
                PopupService.confirmDialog(
                  context: context,
                  child: Text(
                    "'${playlist.title}' will be deleted.",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ).then((value) {
                  if (value ?? false) {
                    if (playlist.id == Persistence.currentlyShowingPlaylistId) {
                      AppNavigator.tryPopRight(context);
                    }
                    PlaylistStorageProvider().remove(playlist);
                  }
                });
                return;
              }

              if (playlist.id == Persistence.currentlyShowingPlaylistId) {
                AppNavigator.tryPopRight(context);
              }
              PlaylistStorageProvider().remove(playlist);
            },
            child: const ContextBody(
              text: "Delete",
              icon: Icons.delete_outline,
            ),
          )
        ],
      ),
      borderRadius: borderRadius,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          children: [
            Thumbnail(
              thumbnail: playlist.thumbnail,
              borderRadius: thumbnailBorderRadius,
              height: 100,
              width: 100,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Tooltip(
                      message: playlist.title,
                      child: Text(
                        playlist.title,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "by $author",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .withOpacity(.5),
                          ),
                        ),
                        playlist.state != null && !canReorder
                            ? Icon(
                                playlist.state!.icon,
                                color: playlist.state!.color,
                              )
                            : const Icon(
                                Icons.question_mark,
                                color: Colors.transparent,
                              )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (canReorder) const Icon(Icons.drag_handle),
          ],
        ),
      ),
    );
  }
}
