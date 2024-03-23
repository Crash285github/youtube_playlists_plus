import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/extensions/int_to_ordinal.dart';
import 'package:ytp_new/extensions/string_hide_topic.dart';
import 'package:ytp_new/extensions/text_style_with_opacity.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/provider/settings_provider.dart';
import 'package:ytp_new/view/widget/media_item_template.dart';
import 'package:ytp_new/view/widget/thumbnail.dart';

class AnchorItem extends StatelessWidget {
  final String playlistId;
  final Video video;
  final bool isFirst, isLast;
  const AnchorItem({
    super.key,
    required this.playlistId,
    required this.video,
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

  String get anchorInformation {
    String text = 'Position changed: ${video.anchor!.index} > ${video.index}';

    return text;
  }

  Playlist get playlist => PlaylistStorageProvider().fromId(playlistId)!;

  @override
  Widget build(BuildContext context) {
    context.watch<SettingsProvider>();

    return MediaItem(
      borderRadius: borderRadius,
      primaryAction: (_) => _infoSheet(context),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          children: [
            Thumbnail(
              thumbnail: video.thumbnail,
              borderRadius: thumbnailBorderRadius,
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
                      anchorInformation,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .withOpacity(.5),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _infoSheet(BuildContext context) => showModalBottomSheet(
        context: context,
        elevation: 0,
        backgroundColor: Colors.transparent,
        builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16.0),
                  topLeft: Radius.circular(16.0),
                ),
                color: Theme.of(context).colorScheme.background,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Anchor info",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Divider(),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        children: [
                          Thumbnail(
                            thumbnail: video.thumbnail,
                            height: 80,
                            width: 80,
                            borderRadius: BorderRadius.circular(6.0),
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
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Should be "
                                    "${video.anchor!.index.toOrdinalString()} "
                                    "in playlist",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .withOpacity(.5),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    "Video at this position:",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        children: [
                          Thumbnail(
                            thumbnail: playlist[video.anchor!.index].thumbnail,
                            height: 80,
                            width: 80,
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    playlist[video.anchor!.index].title,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    SettingsProvider().hideTopic
                                        ? playlist[video.anchor!.index]
                                            .author
                                            .hideTopic()
                                        : playlist[video.anchor!.index].author,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .withOpacity(.5),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      );
}
