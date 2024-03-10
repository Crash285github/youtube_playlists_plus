import 'package:flutter/material.dart';
import 'package:ytp_new/extensions/text_style_with_opacity.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/service/app_navigator.dart';
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

  @override
  Widget build(BuildContext context) {
    return MediaItemTemplate(
      onTap: (_) {
        AppNavigator.tryPopRight();
        AppNavigator.tryPushRight(PlaylistPage(playlistId: playlist.id));
      },
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
                    Text(
                      playlist.title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            playlist.author,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .withOpacity(.5),
                          ),
                        ),
                        if (playlist.state != null)
                          Icon(
                            playlist.state!.icon,
                            color: playlist.state!.color,
                          )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
