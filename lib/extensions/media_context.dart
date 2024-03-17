import 'package:flutter/material.dart';
import 'package:ytp_new/extensions/string_to_clipboard.dart';
import 'package:ytp_new/model/media.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/model/video/anchor.dart';
import 'package:ytp_new/model/video/video.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/service/popup_service.dart';

extension MediaContext on Media {
  PopupMenuItem get contextOpen => PopupMenuItem(
        onTap: () => open(),
        child: const Text("Open"),
      );

  PopupMenuItem get contextCopyTitle => PopupMenuItem(
        onTap: () => title.copyToClipboard(),
        child: const Text("Copy title"),
      );

  PopupMenuItem get contextCopyId => PopupMenuItem(
        onTap: () => id.copyToClipboard(),
        child: const Text("Copy id"),
      );

  PopupMenuItem get contextCopyLink => PopupMenuItem(
        onTap: () => link.copyToClipboard(),
        child: const Text("Copy link"),
      );
}

extension PlaylistContext on Playlist {
  PopupMenuItem get contextDelete => PopupMenuItem(
        onTap: () => PlaylistStorageProvider().remove(this),
        child: const Text("Delete"),
      );
}

extension VideoContext on Video {
  PopupMenuItem get contextDownload => PopupMenuItem(
        onTap: () => download(),
        child: const Text("Download"),
      );

  PopupMenuItem contextSetAnchor(BuildContext context) => PopupMenuItem(
        onTap: () async {
          AnchorPosition position = AnchorPosition.start;
          int offset = 0;

          final anchor = await PopupService.showPopup<Anchor>(
            context: context,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _AnchorChip(
                      "Start",
                      () => position = AnchorPosition.start,
                    ),
                    _AnchorChip(
                      "Middle",
                      () => position = AnchorPosition.middle,
                    ),
                    _AnchorChip(
                      "End",
                      () => position = AnchorPosition.end,
                    ),
                  ],
                ),
                _AnchorSlider(
                  20,
                  (changed) => offset = changed.toInt(),
                )
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, null),
                child: const Text("Unset"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(
                  context,
                  const Anchor(offset: -1, position: AnchorPosition.start),
                ),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(
                  context,
                  Anchor(offset: offset, position: position),
                ),
                child: const Text("Set"),
              ),
            ],
          );

          print("${anchor?.position} ${anchor?.offset}");
        },
        child: const Text("Set Anchor"),
      );
}

class _AnchorChip extends StatelessWidget {
  final String text;
  final Function()? onTap;
  const _AnchorChip(this.text, this.onTap);

  @override
  Widget build(BuildContext context) => Material(
        borderRadius: BorderRadius.circular(1000),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 4.0,
            ),
            child: Text(text),
          ),
        ),
      );
}

class _AnchorSlider extends StatefulWidget {
  final int max;
  final Function(double changed) onChanged;
  const _AnchorSlider(this.max, this.onChanged);

  @override
  State<_AnchorSlider> createState() => __AnchorSliderState();
}

class __AnchorSliderState extends State<_AnchorSlider> {
  double value = 0;
  @override
  Widget build(BuildContext context) => Slider(
        value: value,
        max: widget.max.toDouble(),
        onChanged: (double changed) {
          widget.onChanged(changed);
          setState(() => value = changed);
        },
      );
}
