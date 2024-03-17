import 'package:flutter/material.dart';
import 'package:ytp_new/extensions/offset_context_menu.dart';
import 'package:ytp_new/extensions/string_to_clipboard.dart';
import 'package:ytp_new/model/media.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/model/video/anchor.dart';
import 'package:ytp_new/model/video/video.dart';
import 'package:ytp_new/provider/anchor_storage_provider.dart';
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
          AnchorPosition position =
              this.anchor?.position ?? AnchorPosition.start;
          int offset = this.anchor?.offset ?? 0;

          final anchor = await PopupService.dialog<Anchor>(
            context: context,
            child: StatefulBuilder(
              builder: (context, setState) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Material(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10000),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTapUp: (details) async {
                        final selected = await details.globalPosition
                            .showContextMenu<AnchorPosition>(
                          context: context,
                          items: [
                            const PopupMenuItem(
                              value: AnchorPosition.start,
                              child: Text("Start"),
                            ),
                            const PopupMenuItem(
                              value: AnchorPosition.middle,
                              child: Text("Middle"),
                            ),
                            const PopupMenuItem(
                              value: AnchorPosition.end,
                              child: Text("End"),
                            )
                          ],
                        );

                        if (selected != null) {
                          setState(() => position = selected);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4,
                        ),
                        child: Text(
                          position.name[0].toUpperCase() +
                              position.name.substring(1),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                  ),
                  _AnchorSlider(
                    -20,
                    offset,
                    20,
                    (changed) => offset = changed.toInt(),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(
                  context,
                  Anchor(
                    playlistId: playlistId,
                    videoId: id,
                    position: AnchorPosition.start,
                    offset: -1,
                  ),
                ),
                child: const Text("Unset"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, null),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(
                  context,
                  Anchor(
                    playlistId: playlistId,
                    videoId: id,
                    offset: offset,
                    position: position,
                  ),
                ),
                child: const Text("Set"),
              ),
            ],
          );

          if (anchor != null) {
            AnchorStorageProvider().change(anchor);
          }
        },
        child: const Text("Set Anchor"),
      );
}

class _AnchorSlider extends StatefulWidget {
  final int min;
  final int max;
  final int initialValue;
  final Function(double changed) onChanged;
  const _AnchorSlider(
    this.min,
    this.initialValue,
    this.max,
    this.onChanged,
  );

  @override
  State<_AnchorSlider> createState() => __AnchorSliderState();
}

class __AnchorSliderState extends State<_AnchorSlider> {
  late double value = widget.initialValue.toDouble();

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Slider(
            value: value,
            min: widget.min.toDouble(),
            max: widget.max.toDouble(),
            onChanged: (double changed) {
              widget.onChanged(changed);
              setState(() => value = changed);
            },
          ),
          Text(value.toInt().toString())
        ],
      );
}
