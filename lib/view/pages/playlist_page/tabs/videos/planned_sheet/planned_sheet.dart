import 'package:flutter/material.dart';
import 'package:ytp_new/config.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/view/pages/playlist_page/tabs/videos/planned_sheet/planned_item.dart';

import 'planned_sheet_title.dart';

class PlannedSheet extends StatefulWidget {
  final String playlistId;
  final Iterable<String> planned;
  const PlannedSheet({
    super.key,
    required this.planned,
    required this.playlistId,
  });

  @override
  State<PlannedSheet> createState() => _PlannedSheetState();
}

class _PlannedSheetState extends State<PlannedSheet> {
  late final DraggableScrollableController _controller;
  Playlist get playlist => PlaylistStorageProvider().fromId(widget.playlistId)!;

  @override
  void initState() {
    super.initState();
    _controller = DraggableScrollableController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double minSize = 60 / constraints.maxHeight;
        final double maxSize = 1 - minSize;

        return DraggableScrollableSheet(
          controller: _controller,
          minChildSize: minSize,
          initialChildSize: minSize,
          maxChildSize: maxSize,
          snap: true,
          builder: (context, scrollController) => Center(
            child: Card(
              elevation: 16,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero,
                ),
              ),
              margin: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
              child: ScrollConfiguration(
                behavior: const MaterialScrollBehavior().copyWith(
                  scrollbars: false,
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 20),
                  itemBuilder: (context, index) {
                    //? Title & handle
                    if (index == 0) {
                      return PlannedSheetTitle(
                        playlistId: playlist.id,
                        onTap: () {
                          _controller.animateTo(
                            _controller.size <= .5 ? maxSize : minSize,
                            duration: AppConfig.defaultAnimationDuration,
                            curve: Curves.fastOutSlowIn,
                          );
                        },
                      );
                    }

                    //? items
                    return PlannedItem(
                      playlistId: widget.playlistId,
                      text: widget.planned.elementAt(index - 1),
                    );
                  },
                  itemCount: widget.planned.length + 1,
                  controller: scrollController,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
