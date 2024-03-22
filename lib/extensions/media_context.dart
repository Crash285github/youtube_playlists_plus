import 'package:flutter/material.dart';
import 'package:ytp_new/extensions/popup_anchor_dialog.dart';
import 'package:ytp_new/extensions/string_to_clipboard.dart';
import 'package:ytp_new/model/media.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/model/video/anchor.dart';
import 'package:ytp_new/model/video/video.dart';
import 'package:ytp_new/provider/anchor_storage_provider.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';

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
        child: const Text("Set Anchor"),
      );
}
