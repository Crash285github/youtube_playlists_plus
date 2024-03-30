part of extensions;

class ContextBody extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? iconColor;
  const ContextBody({
    super.key,
    required this.text,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(
            icon,
            color: iconColor ??
                Theme.of(context).colorScheme.onBackground.withOpacity(.5),
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
      child: ContextBody(
        text: "Open",
        icon: Icons.open_in_new,
        iconColor: Settings.theme == ThemeSetting.light
            ? Colors.green
            : Colors.greenAccent,
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
        onTap: () => download(),
        child: const ContextBody(
          text: "Download",
          icon: Icons.download,
          iconColor: Colors.lightGreen,
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
          iconColor: Colors.blue,
        ),
      );
}
