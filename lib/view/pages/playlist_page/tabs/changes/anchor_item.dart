import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/extensions/enum_title_case.dart';
import 'package:ytp_new/extensions/text_style_with_opacity.dart';
import 'package:ytp_new/model/video/video.dart';
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
    required this.isFirst,
    required this.isLast,
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
    String text = 'Position changed: ${video.anchor!.index} > ${video.index}'
        '\nShould be at: [${video.anchor!.position.titleCase}';

    if (video.anchor!.offset != 0) {
      text += ' ${video.anchor!.offset > 0 ? "+" : ""}${video.anchor!.offset}';
    }

    return '$text]';
  }

  @override
  Widget build(BuildContext context) {
    context.watch<SettingsProvider>();
    return MediaItemTemplate(
      borderRadius: borderRadius,
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
}
