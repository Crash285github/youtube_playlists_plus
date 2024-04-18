import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/extensions/extensions.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/provider/preferences_provider.dart';
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

  String get anchorInformation => 'Moved from '
      '${(video.anchor!.index + 1).toOrdinalString()} '
      'to ${(video.index + 1).toOrdinalString()}.';

  Playlist get playlist => PlaylistStorageProvider().fromId(playlistId)!;

  @override
  Widget build(BuildContext context) {
    context.watch<PreferencesProvider>();

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
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
                    child: Text(
                      "Anchor info",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  const Divider(),
                  _AnchorSheetItem(video: video),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Should be "
                      "${(video.anchor!.index + 1).toOrdinalString()} "
                      "video in playlist.",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Video currently at this position:",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  _AnchorSheetItem(video: playlist[video.anchor!.index])
                ],
              ),
            )),
      );
}

class _AnchorSheetItem extends StatelessWidget {
  const _AnchorSheetItem({
    required this.video,
  });

  final Video video;

  String get author =>
      PreferencesProvider().hideTopic ? video.author.hideTopic() : video.author;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.zero,
          topLeft: Radius.zero,
          bottomRight: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      margin: const EdgeInsets.fromLTRB(0, 0, 16.0, 0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 3.0, 3.0, 3.0),
        child: Row(
          children: [
            Thumbnail(
              thumbnail: video.thumbnail,
              height: 80,
              width: 80,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.zero,
                topLeft: Radius.zero,
                bottomRight: Radius.circular(6.0),
                topRight: Radius.circular(6.0),
              ),
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
                      "by $author",
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
    );
  }
}
