import 'dart:isolate';

import 'package:flutter/material.dart';

import 'package:ytp_new/extensions/popup_anchor_dialog.dart';
import 'package:ytp_new/extensions/string_to_clipboard.dart';
import 'package:ytp_new/provider/anchor_storage_provider.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';

class ContextBody extends StatelessWidget {
  final String text;
  final IconData icon;
  const ContextBody({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
          ),
        ),
        Text(text),
      ],
    );
  }
}

extension MediaContext on Media {
  PopupMenuItem get contextOpen => PopupMenuItem(
      onTap: () => open(),
      child: const ContextBody(
        text: "Open",
        icon: Icons.open_in_new,
      ));

  PopupMenuItem get contextCopyTitle => PopupMenuItem(
        onTap: () => title.copyToClipboard(),
        child: const ContextBody(
          text: "Copy title",
          icon: Icons.copy,
        ),
      );

  PopupMenuItem get contextCopyId => PopupMenuItem(
        onTap: () => id.copyToClipboard(),
        child: const ContextBody(
          text: "Copy id",
          icon: Icons.copy,
        ),
      );

  PopupMenuItem get contextCopyLink => PopupMenuItem(
        onTap: () => link.copyToClipboard(),
        child: const ContextBody(
          text: "Copy link",
          icon: Icons.copy,
        ),
      );
}

extension VideoContext on Video {
  PopupMenuItem get contextDownload => PopupMenuItem(
        onTap: () => Isolate.run(() => download()),
        child: const ContextBody(
          text: "Download",
          icon: Icons.download,
        ),
      );

  PopupMenuItem contextSetAnchor(BuildContext context) => PopupMenuItem(
        onTap: () async {
          final anchor = await AnchorDialog.show(context: context, video: this);

          if (anchor != null) {
            if (anchor.position == AnchorPosition.start &&
                anchor.offset == -1) {
              AnchorStorageProvider().remove(anchor);
            } else {
              AnchorStorageProvider().change(anchor);
            }
          }
        },
        child: const ContextBody(
          text: "Set Anchor",
          icon: Icons.anchor,
        ),
      );
}
