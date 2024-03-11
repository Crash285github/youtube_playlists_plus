import 'package:flutter/material.dart';
import 'package:ytp_new/extensions/string_to_clipboard.dart';
import 'package:ytp_new/model/media.dart';

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
