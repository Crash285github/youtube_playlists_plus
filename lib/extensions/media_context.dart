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
  Widget build(BuildContext context) => Row(
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

extension MediaContext on Media {
  /// Returns a [PopupMenuItem] to open a [Media]
  PopupMenuItem get contextOpen => PopupMenuItem(
      onTap: () => open(),
      child: ContextBody(
        text: "Open",
        icon: Icons.open_in_new,
        iconColor: Preferences.theme == ThemePreference.light
            ? Colors.green
            : Colors.greenAccent,
      ));

  /// Returns a [PopupMenuItem] to copy the title of a [Media]
  PopupMenuItem get contextCopyTitle => PopupMenuItem(
        onTap: () => title.copyToClipboard(),
        child: const ContextBody(
          text: "Copy title",
          icon: Icons.copy,
        ),
      );

  /// Returns a [PopupMenuItem] to copy the id of a [Media]
  PopupMenuItem get contextCopyId => PopupMenuItem(
        onTap: () => id.copyToClipboard(),
        child: const ContextBody(
          text: "Copy id",
          icon: Icons.copy,
        ),
      );

  /// Returns a [PopupMenuItem] to copy the link of a [Media]
  PopupMenuItem get contextCopyLink => PopupMenuItem(
        onTap: () => link.copyToClipboard(),
        child: const ContextBody(
          text: "Copy link",
          icon: Icons.copy,
        ),
      );
}

extension VideoContext on Video {
  /// Returns a [PopupMenuItem] to download a [Video]
  PopupMenuItem get contextDownload => PopupMenuItem(
        onTap: () => download(),
        child: const ContextBody(
          text: "Download",
          icon: Icons.download,
          iconColor: Colors.lightGreen,
        ),
      );

  /// Returns a [PopupMenuItem] to set the [Anchor] of a [Video]
  PopupMenuItem contextSetAnchor(BuildContext context) => PopupMenuItem(
        onTap: () async {
          final offsetController = TextEditingController();

          final anchor = await _showAnchorDialog(
            context: context,
            video: this,
            offsetController: offsetController,
          );

          offsetController.dispose();
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

  /// Shows a dialog to set the [Anchor] of a [Video]
  static Future<Anchor?> _showAnchorDialog({
    required BuildContext context,
    required Video video,
    required TextEditingController offsetController,
  }) async {
    AnchorPosition position = video.anchor?.position ?? AnchorPosition.start;
    int offset = video.anchor?.offset ?? video.index;
    offsetController.text = "$offset";

    final anchor = await PopupService.dialog<Anchor>(
      context: context,
      child: StatefulBuilder(
        builder: (context, setState) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(8),
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
                  setState(() {
                    position = selected;
                    offsetController.text = switch (position) {
                      AnchorPosition.start => video.index,
                      AnchorPosition.middle =>
                        video.index - video.playlist.length ~/ 2 + 1,
                      AnchorPosition.end =>
                        video.index - video.playlist.length + 1,
                    }
                        .toString();
                  });
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
            TextField(
              decoration: const InputDecoration(labelText: "Offset"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("^-?\\d*")),
              ],
              controller: offsetController,
              onSubmitted: (_) {
                offset = int.tryParse(offsetController.value.text) ?? 0;
              },
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

    return anchor;
  }
}
