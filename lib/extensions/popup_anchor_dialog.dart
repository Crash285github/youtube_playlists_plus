import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ytp_new/extensions/offset_context_menu.dart';
import 'package:ytp_new/model/video/anchor.dart';
import 'package:ytp_new/model/video/video.dart';
import 'package:ytp_new/service/popup_service.dart';

extension AnchorDialog on PopupService {
  //Todo: bounds of offset
  //todo: auto-calculate current position of video

  static Future<Anchor?> show(
      {required BuildContext context, required Video video}) async {
    AnchorPosition position = video.anchor?.position ?? AnchorPosition.start;
    int offset = video.anchor?.offset ?? 0;

    final offsetController = TextEditingController(text: "$offset");

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
                    position.name[0].toUpperCase() + position.name.substring(1),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Offset"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("^-?\\d*")),
              ],
              controller: offsetController,
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(
            context,
            Anchor(
              playlistId: video.playlistId,
              videoId: video.id,
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
          onPressed: () {
            offset = int.tryParse(offsetController.value.text) ?? 0;
            Navigator.pop(
              context,
              Anchor(
                playlistId: video.playlistId,
                videoId: video.id,
                offset: offset,
                position: position,
              ),
            );
          },
          child: const Text("Set"),
        ),
      ],
    );

    offsetController.dispose();
    return anchor;
  }
}
