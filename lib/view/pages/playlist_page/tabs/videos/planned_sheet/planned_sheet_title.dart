import 'package:flutter/material.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/service/popup_service.dart';

class PlannedSheetTitle extends StatelessWidget {
  final void Function()? onTap;
  final String playlistId;
  const PlannedSheetTitle({
    super.key,
    this.onTap,
    required this.playlistId,
  });

  Playlist get playlist => PlaylistStorageProvider().fromId(playlistId)!;

  Future addPlanned(BuildContext context) async {
    final controller = TextEditingController();

    final planned = await PopupService.dialog<String>(
      context: context,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: TextField(
          controller: controller,
          decoration: const InputDecoration(
            label: Text("Add a video title to planned"),
          ),
          minLines: 1,
          maxLines: 5,
          autofocus: true,
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              Navigator.pop(context, value);
            }
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, controller.text),
          child: const Text("Add"),
        )
      ],
    );

    if (planned != null && planned.trim().isNotEmpty) {
      PlaylistStorageProvider().update(
        () => playlist.planned.add(planned.trim()),
        save: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 48,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 4.0,
              right: 8.0,
            ),
            child: InkWell(
              onTap: onTap,
              overlayColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.primary.withOpacity(.3),
              ),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(14.0),
                bottomRight: Radius.circular(14.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Planned",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    IconButton(
                      onPressed: () => addPlanned(context),
                      icon: const Icon(Icons.add),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        const Divider(
          height: 12.0,
          indent: 8.0,
          endIndent: 8.0,
        )
      ],
    );
  }
}
