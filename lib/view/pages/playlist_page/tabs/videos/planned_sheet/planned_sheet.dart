import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ytp_new/view/pages/playlist_page/tabs/videos/planned_sheet/planned_item.dart';
import 'package:ytp_new/view/widget/fading_listview.dart';

import 'planned_sheet_title.dart';

class PlannedSheet extends StatefulWidget {
  final String playlistId;
  final List<String> planned;
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
  double bottomMargin = 8.0;

  @override
  void initState() {
    super.initState();
    _controller = DraggableScrollableController()
      ..addListener(
        () => setState(
          () => bottomMargin = max(0, 8 - (_controller.size * 9)),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    //todo left off here
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final double minSize = 64 / constraints.maxHeight;
            final double maxSize = 1 - minSize;

            return DraggableScrollableSheet(
              controller: _controller,
              minChildSize: minSize,
              initialChildSize: minSize,
              maxChildSize: maxSize,
              snap: true,
              builder: (context, scrollController) => Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Card(
                    elevation: 16,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(8.0),
                      topRight: const Radius.circular(8.0),
                      bottomLeft: Radius.circular(bottomMargin),
                      bottomRight: Radius.circular(bottomMargin),
                    )),
                    margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, bottomMargin),
                    child: ScrollConfiguration(
                      behavior: const MaterialScrollBehavior().copyWith(
                        scrollbars: false,
                      ),
                      child: FadingListView(
                        padding: const EdgeInsets.only(bottom: 20),
                        bottom: _controller.size >= minSize + .01,
                        itemBuilder: (context, index) {
                          //? Title & handle
                          if (index == 0) {
                            return PlannedSheetTitle(
                              plannedLength: widget.planned.length,
                              onTap: () {
                                _controller.animateTo(
                                  _controller.size <= .5 ? maxSize : minSize,
                                  duration: Durations.short4,
                                  curve: Curves.decelerate,
                                );
                              },
                            );
                          }

                          //? items
                          return PlannedItem(
                            playlistId: widget.playlistId,
                            text: widget.planned[index - 1],
                          );
                        },
                        itemCount: widget.planned.length + 1,
                        controller: scrollController,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
